package ru.agentlab.maia.context.injector.e4.internal

import java.util.ArrayList
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory
import ru.agentlab.maia.context.injector.e4.E4MaiaContextInjector

class Activator implements BundleActivator {

	static BundleContext context

	val registrations = new ArrayList<ServiceRegistration<?>>

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext ctx) throws Exception {
		context = ctx
		context => [
			registrations += registerService(IMaiaContextFactory, new E4MaiaContextFactory, null)
			registrations += registerService(IMaiaContextInjector, new E4MaiaContextInjector, null)
		]
	}

	override stop(BundleContext ctx) throws Exception {
		context = null
		
		registrations.forEach [
			unregister
		]
	}

}