package ru.agentlab.maia.context.injector.e4.internal

import java.util.ArrayList
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService
import ru.agentlab.maia.context.injector.e4.E4MaiaContext
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
		val maiaContext = new E4MaiaContext(EclipseContextFactory.create) => [
			set(IMaiaContext, it)
			set(IMaiaContextInjector, new E4MaiaContextInjector(it))
			set(IMaiaContextFactory, new E4MaiaContextFactory(it))
			set(IMaiaContextInitializerService, new MaiaContextInitializerService(it))
		]
		registrations += context.registerService(IMaiaContext, maiaContext, null)
	}

	override stop(BundleContext ctx) throws Exception {
		context = null

		registrations.forEach [
			unregister
		]
	}

}