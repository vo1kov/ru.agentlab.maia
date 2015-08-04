package ru.agentlab.maia.context.injector.e4.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory
import ru.agentlab.maia.context.injector.e4.E4MaiaContextInjector
import ru.agentlab.maia.event.IMaiaEventBroker

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

	def static IMaiaEventBroker getEventBroker() {
		val ref = Activator.context.getServiceReference(IMaiaEventBroker)
		if (ref != null) {
			return Activator.context.getService(ref)
		} else {
			throw new IllegalStateException("IEventBroker is not registered")
		}
	}

	def private void unregister(BundleContext context, Class<?> clazz) {
		val ref = context.getServiceReference(clazz)
		if (ref != null) {
			context.ungetService(ref)
		}
	}

}
