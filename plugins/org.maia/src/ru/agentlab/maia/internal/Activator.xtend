package ru.agentlab.maia.internal

import org.osgi.framework.BundleContext
import ru.agentlab.maia.IMaiaContextServiceManager
import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.internal.initializer.MaiaContextInitializerService
import ru.agentlab.maia.internal.service.MaiaContextServiceManager
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override getProfile() {
		return new MaiaProfile => [
			put(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}

	override start(BundleContext context) throws Exception {
		super.start(context)
		context => [
			registerService(IMaiaContextServiceManager, new MaiaContextServiceManager, null)
			registerService(IMaiaContextInitializerService, new MaiaContextInitializerService, null)
		]
	}

}
