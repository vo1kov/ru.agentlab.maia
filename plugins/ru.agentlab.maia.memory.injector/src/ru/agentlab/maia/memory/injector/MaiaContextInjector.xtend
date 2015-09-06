package ru.agentlab.maia.memory.injector

import java.lang.annotation.Annotation
import java.lang.reflect.Constructor
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method
import java.lang.reflect.Modifier
import java.lang.reflect.Type
import java.util.ArrayList
import java.util.Arrays
import java.util.Collections
import java.util.Comparator
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.exception.MaiaDeploymentException
import ru.agentlab.maia.memory.exception.MaiaInjectionException

class MaiaContextInjector implements IMaiaContextInjector {

	val public static Object NOT_A_VALUE = new Object()

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override <T> T make(Class<T> clazz) {
		try {
			val constructors = clazz.declaredConstructors

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
				val instance = constructor.callConstructor
				if (instance != null) {
					inject(instance)
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

	def void invoke(Object object, String methodName) {
		val method = object.class.declaredMethods.findFirst[it.name == name]
		object.invoke(method)
	}

	def Object invoke(Object object, Method method) {
		val actualArgs = resolveArgs(method.parameterTypes)
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

	override void inject(Object object) throws MaiaInjectionException {
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

	def protected <T> T callConstructor(Constructor<T> constructor) {
		val modifiers = constructor.modifiers
		if (((modifiers.bitwiseAnd(Modifier.PRIVATE)) != 0) || ((modifiers.bitwiseAnd(Modifier.PROTECTED)) != 0)) {
			return null
		}
		if (!constructor.isAnnotationPresent(Inject) && constructor.parameterTypes.length != 0) {
			return null
		}

		val actualArgs = resolveArgs(constructor.parameterTypes)
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

	def protected Object[] resolveArgs(Type[] parameterTypes) {
		val result = newArrayOfSize(parameterTypes.length)
		Arrays.fill(result, NOT_A_VALUE)
		for (i : 0 ..< parameterTypes.size) {
			val type = parameterTypes.get(i)
			val obj = context.get(type.typeName)
			if (obj != null) {
				result.set(i, obj)
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

	/**
	 * PostConstruct method is invoked before registration service in context.
	 * Services can remove old services from context in PostConstruct method.
	 */
	override <T> deploy(Class<T> serviceClass) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(serviceClass, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override deploy(Object service) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(service.class.name, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override <T> deploy(Class<T> serviceClass, String key) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(key, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override <T> deploy(Class<? extends T> serviceClass, Class<T> interf) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(interf, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override deploy(Object service, String key) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(key, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override <T> deploy(T service, Class<T> interf) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(interf, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override invoke(Object object, Class<? extends Annotation> qualifier,
		Object defaultValue) throws MaiaInjectionException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}