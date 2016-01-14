package ru.agentlab.maia.adapter.internal

import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext

class Activator implements BundleActivator {

	@Accessors
	var static BundleContext context

	override start(BundleContext context) throws Exception {
		Activator.context = context
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}
