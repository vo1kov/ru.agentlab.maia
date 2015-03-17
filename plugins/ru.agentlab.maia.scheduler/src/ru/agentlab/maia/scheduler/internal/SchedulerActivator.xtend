package ru.agentlab.maia.scheduler.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.scheduler.ISchedulerProvider

class SchedulerActivator implements BundleActivator {
	static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		SchedulerActivator.context = bundleContext
		context.registerService(ISchedulerProvider, new SchedulerProvider(), null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		SchedulerActivator.context = null
	}

}
