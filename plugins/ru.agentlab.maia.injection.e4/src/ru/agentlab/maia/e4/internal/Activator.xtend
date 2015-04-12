package ru.agentlab.maia.e4.internal

import org.osgi.framework.BundleContext
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.IMaiaContextFactory
import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.e4.E4MaiaContext
import ru.agentlab.maia.e4.E4MaiaContextFactory
import ru.agentlab.maia.e4.E4MaiaContextInjector
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile => [
			put(IMaiaContext, E4MaiaContext)
			put(IMaiaContextFactory, E4MaiaContextFactory)
			put(IMaiaContextInjector, E4MaiaContextInjector)
		]
	}

	override start(BundleContext context) throws Exception {
		super.start(context)
		registerOsgiService(IMaiaContextFactory, new E4MaiaContextFactory)
		registerOsgiService(IMaiaContextInjector, new E4MaiaContextInjector)
	}

}
