package ru.agentlab.maia.internal.service

import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.service.IServiceManagementService

class ServiceManagementService implements IServiceManagementService {

	val static LOGGER = LoggerFactory.getLogger(ServiceManagementService)

	override <T> copyService(IEclipseContext fromContext, IEclipseContext toContext,
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

	override copyService(IEclipseContext fromContext, IEclipseContext toContext,
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

	override <T> moveService(IEclipseContext fromContext, IEclipseContext toContext,
		Class<T> serviceClass) throws IllegalStateException {
		val service = fromContext.copyService(toContext, serviceClass)
		ContextInjectionFactory.inject(service, toContext)
		fromContext.removeService(serviceClass)
	}

	override moveService(IEclipseContext fromContext, IEclipseContext toContext,
		String serviceName) throws IllegalStateException {
		val service = fromContext.copyService(toContext, serviceName)
		ContextInjectionFactory.inject(service, toContext)
		fromContext.removeService(serviceName)
	}

	override <T> addService(IEclipseContext context, Class<T> serviceClass, T service) {
		LOGGER.debug("	Add Service [{}] with vale [{}] to [{}] context...", serviceClass.name, service, context)
		context.set(serviceClass, service)
	}

	override addService(IEclipseContext context, String serviceName, Object service) {
		LOGGER.debug("	Add Service [{}] with vale [{}] to [{}] context...", serviceName, service, context)
		context.set(serviceName, service)
	}

	override <T> removeService(IEclipseContext context, Class<T> serviceClass) {
		LOGGER.debug("	Remove [{}] Service from [{}] context...", serviceClass.simpleName, context)
		context.remove(serviceClass)
	}

	override removeService(IEclipseContext context, String serviceName) {
		LOGGER.debug("	Remove [{}] Service from [{}] context...", serviceName, context)
		context.remove(serviceName)
	}

}