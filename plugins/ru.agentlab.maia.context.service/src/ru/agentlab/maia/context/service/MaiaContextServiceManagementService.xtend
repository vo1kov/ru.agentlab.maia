package ru.agentlab.maia.context.service

import javax.annotation.PostConstruct
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.profile.IMaiaProfile

class MaiaContextServiceManagementService implements IMaiaContextServiceManagementService {

	val static LOGGER = LoggerFactory.getLogger(MaiaContextServiceManagementService)

	override <T> copyService(IMaiaContext fromContext, IMaiaContext toContext,
		Class<T> serviceClass) throws IllegalStateException{
		val service = fromContext.get(serviceClass)
		if (service != null) {
			LOGGER.debug("	Copy [{}] Service from [{}] to [{}] context...", serviceClass.simpleName, fromContext,
				toContext)
			toContext.set(serviceClass, service)
			return service
		} else {
			throw new IllegalStateException("Context [" + fromContext + "] have no [" + serviceClass + "] service")
		}
	}

	override copyService(IMaiaContext fromContext, IMaiaContext toContext,
		String serviceName) throws IllegalStateException{
		val service = fromContext.get(serviceName)
		if (service != null) {
			LOGGER.debug("	Copy [{}] Service from [{}] to [{}] context...", serviceName, fromContext, toContext)
			toContext.set(serviceName, service)
			return service
		} else {
			throw new IllegalStateException("Context [" + fromContext + "] have no [" + serviceName + "] service")
		}
	}

	override <T> moveService(IMaiaContext fromContext, IMaiaContext toContext,
		Class<T> serviceClass) throws IllegalStateException {
		val injector = toContext.get(IMaiaContextInjector)
		val service = fromContext.copyService(toContext, serviceClass)
		injector.inject(service, toContext)
		fromContext.removeService(serviceClass)
	}

	override moveService(IMaiaContext fromContext, IMaiaContext toContext,
		String serviceName) throws IllegalStateException {
		val injector = toContext.get(IMaiaContextInjector)
		val service = fromContext.copyService(toContext, serviceName)
		injector.inject(service, toContext)
		fromContext.removeService(serviceName)
	}

	override <T> addService(IMaiaContext context, Class<T> serviceClass, T service) {
		LOGGER.debug("	Add Service [{}] with vale [{}] to [{}] context...", serviceClass.name, service, context)
		context.set(serviceClass, service)
	}

	override addService(IMaiaContext context, String serviceName, Object service) {
		LOGGER.debug("	Add Service [{}] with vale [{}] to [{}] context...", serviceName, service, context)
		context.set(serviceName, service)
	}

	override <T> removeService(IMaiaContext context, Class<T> serviceClass) {
		LOGGER.debug("	Remove [{}] Service from [{}] context...", serviceClass.simpleName, context)
		context.remove(serviceClass)
	}

	override removeService(IMaiaContext context, String serviceName) {
		LOGGER.debug("	Remove [{}] Service from [{}] context...", serviceName, context)
		context.remove(serviceName)
	}

//	override <T> createService(IMaiaContext context, Class<T> serviceClass) {
//		val injector = context.get(IMaiaContextInjector)
//		val profile = context.get(IMaiaProfile)
//		val implementationClass = profile.get(serviceClass)
//		val service = injector.make(implementationClass, context)
//		injector.invoke(service, PostConstruct, context, null)
//		addService(context, serviceClass, service)
//		return service
//	}
//	override <T> getService(IMaiaContext context, Class<T> serviceClass) {
//		var result = context.get(serviceClass)
//		if (result != null) {
//			return result
//		} else {
//			val injector = context.get(IMaiaContextInjector)
//			if (injector == null) {
//				throw new IllegalStateException("Context have no injector")
//			}
//			val profile = context.get(IMaiaProfile)
//			if (profile == null) {
//				throw new IllegalStateException("Context have no profile")
//			}
//			val implClass = profile.get(serviceClass)
//			if (implClass == null) {
//				throw new IllegalStateException("Profile have no [" + serviceClass + "] implementation")
//			}
//			result = injector.make(implClass, context)
//			injector.invoke(result, PostConstruct, context, null)
//			context.set(serviceClass, result)
//		}
//		return result
//	}
	override <T> T createService(IMaiaProfile profile, IMaiaContext serviceContext, Class<T> clazz) {
		val serviceClass = profile.getImplementation(clazz)
		if (serviceClass != null) {
			val injector = serviceContext.get(IMaiaContextInjector)
			val service = injector.make(serviceClass, serviceContext)
			injector.invoke(service, PostConstruct, serviceContext, null)
			serviceContext.set(clazz, service)
			return service
		}
	}

	override <T> T createServiceFromFactory(IMaiaProfile profile, IMaiaContext factoryContext,
		IMaiaContext serviceContext, Class<T> clazz) {
		if (clazz == null) {
			return null
		}
		val injector = factoryContext.get(IMaiaContextInjector)
		val factoryClass = profile.getFactory(clazz)
		var factory = factoryContext.get(factoryClass)
		if (factory == null) {
			if (factoryClass != null) {
				factory = injector.make(factoryClass, factoryContext)
				injector.invoke(factory, PostConstruct, factoryContext, null)
				factoryContext.set(factoryClass.name, factory)
			}
		}
		return injector.invoke(factory, Create, serviceContext) as T
	}

}