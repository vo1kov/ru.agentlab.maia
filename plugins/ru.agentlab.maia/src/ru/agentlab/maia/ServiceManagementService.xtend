package ru.agentlab.maia

import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.internal.MaiaActivator

class ServiceManagementService implements IServiceManagementService {

	val static LOGGER = LoggerFactory.getLogger(ServiceManagementService)

	override <T> moveFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		context.copyFromRoot(serviceClass)
		context.parent.set(serviceClass, null)
	}

	override <T> copyFromRoot(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		val rootContext = context.parent
		rootContext.copyTo(context, serviceClass)
	}

	override <T> copyFromOsgi(IEclipseContext context, Class<T> serviceClass) throws IllegalStateException{
		val rootContext = EclipseContextFactory.getServiceContext(MaiaActivator.context)
		rootContext.copyTo(context, serviceClass)
	}

	def private <T> void copyTo(IEclipseContext root, IEclipseContext context,
		Class<T> serviceClass) throws IllegalStateException{
		val service = root.get(serviceClass)
		if (service != null) {
			LOGGER.debug("	Put [{}] Service to [{}] context...", serviceClass.simpleName, context)
			context.set(serviceClass, service)
		} else {
			throw new IllegalStateException("Context [" + root + "] have no [" + serviceClass + "] service")
		}
	}

}