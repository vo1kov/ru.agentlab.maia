package ru.agentlab.maia.memory.injector

import java.lang.annotation.Annotation
import java.lang.reflect.Constructor
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method
import java.lang.reflect.Type
import java.util.ArrayList
import java.util.Arrays
import java.util.Collections
import java.util.Comparator
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.exception.MaiaInjectionException
import java.lang.reflect.Parameter

class MaiaContextInjector implements IMaiaContextInjector {

	val public static Object NOT_A_VALUE = new Object

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override <T> T make(Class<T> clazz) {
		try {
			val constructors = clazz.constructors

			val sortedConstructors = new ArrayList<Constructor<T>>(constructors.length)
			for (constructor : constructors) {
				sortedConstructors.add(constructor as Constructor<T>)
			}

			val Comparator<Constructor<T>> comparator = [ c1, c2 |
				val l1 = c1.parameterTypes.length
				val l2 = c2.parameterTypes.length
				return l2 - l1
			]
			Collections.sort(sortedConstructors, comparator)

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

	override invoke(Object object, Class<? extends Annotation> ann) {
		val method = object.class.declaredMethods.findFirst[isAnnotationPresent(ann)]
		object.invoke(method)
	}

	override void invoke(Object object, String methodName) {
		val method = object.class.declaredMethods.findFirst[it.name == name]
		object.invoke(method)
	}

	override Object invoke(Object object, Method method) {
		val actualArgs = resolveArgs(method.parameters)
		if (actualArgs.unresolved != -1) {
			return null
		}
		var Object result = null
		var wasAccessible = true
		if (!method.accessible) {
			method.setAccessible(true)
			wasAccessible = false
		}
		try {
			result = method.invoke(object, actualArgs)
		} catch (IllegalArgumentException e) {
			throw new MaiaInjectionException(e)
		} catch (IllegalAccessException e) {
			throw new MaiaInjectionException(e)
		} catch (InvocationTargetException e) {
			throw new MaiaInjectionException(e)
		} finally {
			if (!wasAccessible)
				method.setAccessible(false)
			clearArray(actualArgs)
		}
		return result
	}

	override invoke(Object object, Class<? extends Annotation> qualifier,
		Object defaultValue) throws MaiaInjectionException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override invoke(Object object, String methodName, Object defaultValue) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override invoke(Object object, Method method, Object defaultValue) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override void inject(Object object) throws MaiaInjectionException {
	}

	/**
	 * PostConstruct method is invoked before registration service in context.
	 * Services can remove old services from context in PostConstruct method.
	 */
	override <T> deploy(Class<T> serviceClass) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(serviceClass, service)
		return service
	}

	override deploy(Object service) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(service.class.name, service)
		return service
	}

	override <T> deploy(Class<T> serviceClass, String key) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(key, service)
		return service
	}

	override <T> deploy(Class<? extends T> serviceClass, Class<T> interf) throws MaiaInjectionException {
		val service = make(serviceClass)
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(interf, service)
		return service
	}

	override deploy(Object service, String key) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(key, service)
		return service
	}

	override <T> deploy(T service, Class<T> interf) throws MaiaInjectionException {
		inject(service)
		invoke(service, PostConstruct, null)
		context.set(interf, service)
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
		val actualArgs = resolveArgs(constructor.parameters)
		if (actualArgs.unresolved != -1) {
			return null
		}
		var T result = null
		var wasAccessible = true
		if (!constructor.accessible) {
			constructor.setAccessible(true)
			wasAccessible = false
		}
		try {
			result = constructor.newInstance(actualArgs)
		} catch (IllegalArgumentException e) {
			throw new MaiaInjectionException(actualArgs.toString + " " + constructor.parameterTypes, e)
		} catch (InstantiationException e) {
			throw new MaiaInjectionException("Unable to instantiate " + constructor, e) // $NON-NLS-1$
		} catch (IllegalAccessException e) {
			throw new MaiaInjectionException(e)
		} catch (InvocationTargetException e) {
			throw new MaiaInjectionException(e)
		} finally {
			if (!wasAccessible)
				constructor.setAccessible(false)
			clearArray(actualArgs)
		}
		return result
	}

	def protected Object[] resolveArgs(Parameter[] parameterTypes) {
		val result = newArrayOfSize(parameterTypes.length)
		Arrays.fill(result, NOT_A_VALUE)
		for (i : 0 ..< parameterTypes.size) {
			val type = parameterTypes.get(i)
			val ctx = context.contains(type.type)
			if (ctx != null) {
				val obj = ctx.get(type.type)
				result.set(i, obj)
			} else {
				return result
			}
		}
		return result
	}

	def protected int unresolved(Object[] actualArgs) {
		for (i : 0 ..< actualArgs.length) {
			if (actualArgs.get(i) == NOT_A_VALUE)
				return i
		}
		return -1
	}

}