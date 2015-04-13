package ru.agentlab.maia.e4.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.e4.E4MaiaContextFactory
import ru.agentlab.maia.e4.E4MaiaContextInjector
import ru.agentlab.maia.injector.IMaiaContextInjector

class Activator implements BundleActivator {

	override start(BundleContext context) throws Exception {
		context => [
			registerService(IMaiaContextFactory, new E4MaiaContextFactory, null)
			registerService(IMaiaContextInjector, new E4MaiaContextInjector, null)
		]
	}
	
	override stop(BundleContext context) throws Exception {
	}

}
