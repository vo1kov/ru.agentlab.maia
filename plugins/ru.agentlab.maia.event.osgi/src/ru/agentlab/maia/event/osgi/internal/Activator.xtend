package ru.agentlab.maia.event.osgi.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.service.event.EventAdmin
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.event.osgi.OsgiEventAdminMaiaBroker

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
		context => [
			registerService(IMaiaEventBroker, new OsgiEventAdminMaiaBroker, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		context => [
			unregister(IMaiaEventBroker)
		]
		Activator.context = null
	}

	def private void unregister(BundleContext context, Class<?> clazz) {
		val ref = context.getServiceReference(clazz)
		if (ref != null) {
			context.ungetService(ref)
		}
	}

	def static EventAdmin getEventAdmin() {
		val ref = Activator.context.getServiceReference(EventAdmin)
		if (ref != null) {
			return Activator.context.getService(ref)
		}
	}

}