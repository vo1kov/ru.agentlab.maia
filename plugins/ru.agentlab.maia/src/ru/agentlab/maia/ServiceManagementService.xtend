package ru.agentlab.maia

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.internal.MaiaActivator

class ServiceManagementService implements IServiceManagementService {

	val static LOGGER = LoggerFactory.getLogger(ServiceManagementService)

	override <T> moveFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		context.copyFromRoot(serviceClass)
		LOGGER.debug("	Remove [{}] Service from [{}] context...", serviceClass.simpleName, context.parent)
		context.parent.remove(serviceClass)
	}

	override <T> copyFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		val rootContext = context.parent
		rootContext.copyTo(context, serviceClass)
	}

	override <T> copyFromOsgi(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		val rootContext = EclipseContextFactory.getServiceContext(MaiaActivator.context)
		rootContext.copyTo(context, serviceClass)
	}

	def private <T> void copyTo(IEclipseContext from, IEclipseContext to,
		Class<T> serviceClass) throws IllegalStateException{
		val service = from.get(serviceClass)
		if (service != null) {
			LOGGER.debug("	Copy [{}] Service from [{}] to [{}] context...", serviceClass.simpleName, from, to)
			to.set(serviceClass, service)
		} else {
			throw new IllegalStateException("Context [" + from + "] have no [" + serviceClass + "] service")
		}
	}

}