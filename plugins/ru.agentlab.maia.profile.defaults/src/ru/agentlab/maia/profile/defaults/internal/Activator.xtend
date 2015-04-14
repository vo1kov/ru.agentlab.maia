package ru.agentlab.maia.profile.defaults.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.AgentFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.MaiaAgentProfile
import ru.agentlab.maia.container.MaiaContainerProfile
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.root.MaiaRootContextProfile
import ru.agentlab.maia.naming.uuid.UuidNameGenerator

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context
		val rootProfile = new MaiaRootContextProfile => [
//			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IAgentFactory, AgentFactory)
//			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
		val containerProfile = new MaiaContainerProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putFactory(IMaiaContext, AgentFactory)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
		val agentProfile = new MaiaAgentProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
		context => [
			registerService(MaiaRootContextProfile, rootProfile, null)
			registerService(MaiaContainerProfile, containerProfile, null)
			registerService(MaiaAgentProfile, agentProfile, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}
