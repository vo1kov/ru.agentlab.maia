package ru.agentlab.maia.internal

import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.internal.messaging.netty.NettyMessageDeliveryServiceFactory
import ru.agentlab.maia.internal.naming.PlatformNameGenerator
import ru.agentlab.maia.internal.platform.PlatformFactory
import ru.agentlab.maia.internal.platform.PlatformIdFactory
import ru.agentlab.maia.internal.service.ServiceManagementService
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.naming.IPlatformNameGenerator
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformIdFactory
import ru.agentlab.maia.service.IServiceManagementService
import ru.agentlab.maia.internal.agent.LocalAgentRegistry

class MaiaActivator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = bundleContext

		EclipseContextFactory.getServiceContext(context) => [
			createService(context, IServiceManagementService, ServiceManagementService)
			createService(context, IMessageDeliveryServiceFactory, NettyMessageDeliveryServiceFactory)

			createService(context, IPlatformIdFactory, PlatformIdFactory)
			createService(context, IPlatformNameGenerator, PlatformNameGenerator)
			createService(context, IPlatformFactory, PlatformFactory)
			
			createService(context, LocalAgentRegistry, LocalAgentRegistry)
		]
	}

	def private <T> void createService(IEclipseContext context, BundleContext bundleContext, Class<T> serviceClass,
		Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, context)
		ContextInjectionFactory.invoke(service, PostConstruct, context, null)
		context.set(serviceClass, service)
		bundleContext.registerService(serviceClass, service, null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = null
	}

}
