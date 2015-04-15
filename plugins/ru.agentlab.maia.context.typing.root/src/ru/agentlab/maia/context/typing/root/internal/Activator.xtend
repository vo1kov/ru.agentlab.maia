package ru.agentlab.maia.context.typing.root.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.typing.root.MaiaRootContextFactory

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
		context => [
			val factory = new MaiaRootContextFactory
			val rootContext = factory.createRootContext
			registerService(IMaiaContext, rootContext, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		context => [
			unregister(IMaiaContext)
		]
		Activator.context = null
	}

	def private void unregister(BundleContext context, Class<?> clazz) {
		val ref = context.getServiceReference(clazz)
		if (ref != null) {
			context.ungetService(ref)
		}
	}

	def static <T> T getService(Class<T> clazz) {
		val ref = context.getServiceReference(clazz)
		if (ref != null) {
			return context.getService(ref)
		}
	}

}
