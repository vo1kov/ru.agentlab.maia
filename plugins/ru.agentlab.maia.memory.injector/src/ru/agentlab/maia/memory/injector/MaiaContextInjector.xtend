package ru.agentlab.maia.memory.injector

import java.lang.annotation.Annotation
import java.lang.reflect.Constructor
import java.lang.reflect.Field
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method
import java.lang.reflect.Parameter
import java.util.ArrayList
import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.exception.MaiaInjectionException

class MaiaContextInjector implements IMaiaContextInjector {

	val public static Object NOT_A_VALUE = new Object

	public IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override <T> T make(Class<T> clazz) {
		try {
			val sortedConstructors = (clazz.constructors as Constructor<T>[]).sortWith [ c1, c2 |
				val l1 = c1.parameterTypes.length
				val l2 = c2.parameterTypes.length
				return l2 - l1
			]

			for (constructor : sortedConstructors) {
				val instance = constructor.tryConstruct
				if (instance != null) {
					return instance
				}
			}
			throw new MaiaInjectionException("Could not find satisfiable constructor in " + clazz.name) // $NON-NLS-1$
		} catch (NoClassDefFoundError e) {
			throw new MaiaInjectionException(e)
		} catch (NoSuchMethodError e) {
			throw new MaiaInjectionException(e)
		}
	}

	override invoke(Object object, Class<? extends Annotation> qualifier) {
		val method = object.class.declaredMethods.findFirst[isAnnotationPresent(qualifier)]
		return object.invoke(method, false, null)
	}

	override invoke(Object object, String methodName) {
		val method = object.class.declaredMethods.findFirst[it.name == name]
		return object.invoke(method, false, null)
	}

	override invoke(Object object, Method method) {
		return object.invoke(method, false, null)
	}

	override invoke(Object object, Class<? extends Annotation> qualifier,
		Object defaultValue) throws MaiaInjectionException {
		val method = object.class.declaredMethods.findFirst[isAnnotationPresent(qualifier)]
		return object.invoke(method, true, defaultValue)
	}

	override invoke(Object object, String methodName, Object defaultValue) {
		val method = object.class.declaredMethods.findFirst[it.name == name]
		return object.invoke(method, true, defaultValue)
	}

	override invoke(Object object, Method method, Object defaultValue) {
		return object.invoke(method, true, defaultValue)
	}

	def protected invoke(Object object, Method method, boolean haveDefault, Object defaultValue) {
		val values = resolveValues(resolveKeys(method.parameters))
		if (values.length < method.parameters.size) {
			if (haveDefault) {
				return defaultValue
			} else {
				throw new MaiaInjectionException
			}
		}
		var Object result = null
		var wasAccessible = true
		if (!method.accessible) {
			method.setAccessible(true)
			wasAccessible = false
		}
		try {
			result = method.invoke(object, values)
		} catch (IllegalArgumentException e) {
			if (haveDefault) {
				return defaultValue
			} else {
				throw new MaiaInjectionException(e)
			}
		} catch (IllegalAccessException e) {
			if (haveDefault) {
				return defaultValue
			} else {
				throw new MaiaInjectionException(e)
			}
		} catch (InvocationTargetException e) {
			if (haveDefault) {
				return defaultValue
			} else {
				throw new MaiaInjectionException(e)
			}
		} finally {
			if (!wasAccessible)
				method.setAccessible(false)
			clearArray(values)
		}
		return result
	}

	override void inject(Object object) throws MaiaInjectionException {
		if (object == null) {
			throw new NullPointerException
		}
		val fields = object.class.declaredFields.filter[isAnnotationPresent(Inject)]
		val keys = resolveKeys(fields)
		val values = resolveValues(keys)
		if (values.length < fields.size) {
			throw new MaiaInjectionException("Unresolved value for type " + keys.get(values.size))
		}
		for (i : 0 ..< fields.length) {
			val field = fields.get(i)
			val value = values.get(i)
			var wasAccessible = true
			if (!field.accessible) {
				field.setAccessible(true)
				wasAccessible = false
			}
			field.set(object, value)
			if (!wasAccessible) {
				field.setAccessible(false)
			}
		}
	}

	/**
	 * PostConstruct method is invoked before registration service in context.
	 * Services can remove old services from context in PostConstruct method.
	 */
	override <T> deploy(Class<T> serviceClass) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(serviceClass, service)
		return service
	}

	override deploy(Object service) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(service.class.name, service)
		return service
	}

	override <T> deploy(Class<T> serviceClass, String key) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(key, service)
		return service
	}

	override <T> deploy(Class<? extends T> serviceClass, Class<T> interf) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(interf, service)
		return service
	}

	override deploy(Object service, String key) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(key, service)
		return service
	}

	override <T> deploy(T service, Class<T> interf) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.putService(interf, service)
		return service
	}

	/**
	 * Don't hold on to the resolved results as it will prevent 
	 * them from being garbage collected. 
	 */
	def protected void clearArray(Object[] args) {
		if (args == null) {
			return
		}
		for (i : 0 ..< args.length) {
			args.set(i, null)
		}
	}

	def protected <T> T tryConstruct(Constructor<T> constructor) {
		if (!constructor.isAnnotationPresent(Inject) && constructor.parameterTypes.length != 0) {
			return null
		}
//			println()
//			println("constructor: " + constructor)
		val params = constructor.parameters
//			println("parameters: ")
//			params.forEach [
//				println("	param: " + it)
//			]
		val keys = resolveKeys(params)
//			println("keys: ")
//			keys.forEach [
//				println("	key: " + it)
//			]
		val values = resolveValues(keys)
//			println("values: ")
//			values.forEach [
//				println("	value: " + it)
//			]
		if (values.length < constructor.parameters.size) {
			return null
		}
		var T result = null
		var wasAccessible = true
		if (!constructor.accessible) {
			constructor.setAccessible(true)
			wasAccessible = false
		}
		try {
//			println("constructor.newInstance")
			result = constructor.newInstance(values)
//			println("result: " + result)
		} catch (IllegalArgumentException e) {
			throw new MaiaInjectionException(values.toString + " " + constructor.parameterTypes, e)
		} catch (InstantiationException e) {
			throw new MaiaInjectionException("Unable to instantiate " + constructor, e) // $NON-NLS-1$
		} catch (IllegalAccessException e) {
			throw new MaiaInjectionException(e)
		} catch (InvocationTargetException e) {
			throw new MaiaInjectionException(e)
		} finally {
			if (!wasAccessible) {
				constructor.setAccessible(false)
			}
			clearArray(values)
		}
		return result
	}

	def protected Object[] resolveKeys(Parameter[] parameters) {
		val Object[] result = newArrayOfSize(parameters.length)
		parameters.forEach [ p, i |
			if (p.isAnnotationPresent(Named)) {
				val name = p.getAnnotation(Named).value
				result.set(i, name)
			} else {
				result.set(i, p.type.boxedType)
			}
		]
		return result
	}

	def protected Object[] resolveKeys(Field[] fields) {
		val injectFields = fields.filter[isAnnotationPresent(Inject)]
		val Object[] result = newArrayOfSize(injectFields.length)
		injectFields.forEach [ p, i |
			if (p.isAnnotationPresent(Named)) {
				val name = p.getAnnotation(Named).value
				result.set(i, name)
			} else {
				result.set(i, p.type.boxedType)
			}
		]
		return result
	}

	def protected getBoxedType(Class<?> type) {
		switch (type) {
			case byte: {
				return Byte
			}
			case short: {
				return Short
			}
			case int: {
				return Integer
			}
			case long: {
				return Long
			}
			case float: {
				return Float
			}
			case double: {
				return Double
			}
			case char: {
				return Character
			}
			case boolean: {
				return Boolean
			}
			default: {
				return type
			}
		}
	}

	def protected Object[] resolveValues(Object[] keys) {
		val result = new ArrayList<Object>
		for (key : keys) {
			switch (key) {
				String: {
					val ctx = context.contains(key)
					if (ctx != null) {
						val value = ctx.getService(key)
						result += value
					} else {
						return result.toArray
					}
				}
				Class<?>: {
					val ctx = context.contains(key)
					if (ctx != null) {
						val value = ctx.getService(key)
						result += value
					} else {
						return result.toArray
					}
				}
				default: {
					return result.toArray
				}
			}
		}
		return result.toArray
	}

}