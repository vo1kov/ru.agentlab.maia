package ru.agentlab.maia.context.injector.e4.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory
import ru.agentlab.maia.context.injector.e4.E4MaiaContextInjector

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
		context => [
			registerService(IMaiaContextFactory, new E4MaiaContextFactory, null)
			registerService(IMaiaContextInjector, new E4MaiaContextInjector, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		context => [
			unregister(IMaiaContextFactory)
			unregister(IMaiaContextInjector)
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
