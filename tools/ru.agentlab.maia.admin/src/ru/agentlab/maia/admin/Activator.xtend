package ru.agentlab.maia.admin

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
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
		println("start admin service " + 9091)
		(new WsAdminServer).main
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
