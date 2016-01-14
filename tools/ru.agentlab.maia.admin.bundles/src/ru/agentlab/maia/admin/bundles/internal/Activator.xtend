package ru.agentlab.maia.admin.bundles.internal

import io.netty.channel.ChannelHandler
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.admin.bundles.BundleHandler
import ru.agentlab.maia.admin.bundles.WsSubscribeBundleHandler

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
		context.registerService(ChannelHandler, new BundleHandler, null)
		context.registerService(ChannelHandler, new WsSubscribeBundleHandler, null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

}
