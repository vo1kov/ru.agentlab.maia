package ru.agentlab.maia.admin.internal

import io.netty.channel.nio.NioEventLoopGroup
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.admin.MaiaAdminBootstrap

class Activator implements BundleActivator {

	public static BundleContext context

	val port = 9091

	val bossGroup = new NioEventLoopGroup

	val workerGroup = new NioEventLoopGroup

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;

		val serverBootstrap = new MaiaAdminBootstrap(bossGroup, workerGroup)
		serverBootstrap.bind(port)
		println("Start admin service on " + port + " port")
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
		
		bossGroup.shutdownGracefully
		workerGroup.shutdownGracefully
	}

}
