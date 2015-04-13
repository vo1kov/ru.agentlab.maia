package ru.agentlab.maia.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}
