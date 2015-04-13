package ru.agentlab.maia.context.service.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.service.MaiaContextServiceManagementService

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
		context => [
			registerService(IMaiaContextServiceManagementService, new MaiaContextServiceManagementService, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		context => [
			unregister(IMaiaContextServiceManagementService)
		]
		Activator.context = null
	}

	def private void unregister(BundleContext context, Class<?> clazz) {
		val ref = context.getServiceReference(clazz)
		if (ref != null) {
			context.ungetService(ref)
		}
	}

}
