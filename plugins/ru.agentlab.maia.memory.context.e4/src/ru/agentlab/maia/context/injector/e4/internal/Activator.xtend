package ru.agentlab.maia.context.injector.e4.internal

import java.util.ArrayList
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.context.injector.e4.E4MaiaContext
import ru.agentlab.maia.context.injector.e4.E4MaiaContextFactory
import ru.agentlab.maia.context.injector.e4.E4MaiaContextInjector
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextFactory
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.IMaiaServiceDeployer

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
//			set(IMaiaServiceDeployer, new MaiaServiceDeployer(it))
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