package ru.agentlab.maia.admin.contexts.internal

import io.netty.channel.ChannelHandler
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.admin.contexts.WsContextListHandler
import ru.agentlab.maia.admin.contexts.WsContextServicesListHandler
import ru.agentlab.maia.admin.contexts.WsContextSubscribeHandler
import ru.agentlab.maia.context.IMaiaContext

class Activator implements BundleActivator {

	public static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;
		context.registerService(ChannelHandler, new WsContextListHandler, null)
		context.registerService(ChannelHandler, new WsContextServicesListHandler, null)
		context.registerService(ChannelHandler, new WsContextSubscribeHandler(null), null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

	def static getRootContext() {
		val reference = Activator.context.getServiceReference(IMaiaContext)
		val service = Activator.context.getService(reference)
		return service
	}
}