package ru.agentlab.maia.context.initializer.root.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.initializer.root.MaiaRootContextInitializer
import ru.agentlab.maia.context.initializer.root.MaiaRootContextTracker
import org.osgi.util.tracker.ServiceTracker

class Activator implements BundleActivator {

	public static BundleContext context
	
	ServiceTracker<?,?> tracker

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;
		tracker = new MaiaRootContextTracker(context, MaiaRootContextInitializer)
		tracker.open
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
		tracker.close
	}

}
