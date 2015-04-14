package ru.agentlab.maia.profile.defaults.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.AgentFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.MaiaAgentProfile
import ru.agentlab.maia.behaviour.BehaviourFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.behaviour.MaiaBehaviourProfile
import ru.agentlab.maia.container.ContainerFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.MaiaContainerProfile
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.root.MaiaRootContextProfile
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool
import ru.agentlab.maia.execution.pool.cached.MaiaCachedExecutorPool
import ru.agentlab.maia.lifecycle.ILifecycleScheme
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.LifecycleService
import ru.agentlab.maia.lifecycle.fipa.FipaLifecycleScheme
import ru.agentlab.maia.naming.uuid.UuidNameGenerator
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.e4.E4MaiaContextFactory
import ru.agentlab.maia.event.IEventBroker
import ru.agentlab.maia.event.osgi.OsgiEventAdminBroker
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.service.MaiaContextServiceManagementService

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context

		val rootProfile = new MaiaRootContextProfile => [
			putImplementation(IEventBroker, OsgiEventAdminBroker)
			putImplementation(IMaiaContextFactory, E4MaiaContextFactory)
			putImplementation(IMaiaContextServiceManagementService, MaiaContextServiceManagementService)
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IContainerFactory, ContainerFactory)
			putImplementation(IMaiaExecutorPool, MaiaCachedExecutorPool)
		]

		val containerProfile = new MaiaContainerProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IAgentFactory, AgentFactory)
			putImplementation(ILifecycleScheme, FipaLifecycleScheme)
			putImplementation(ILifecycleService, LifecycleService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val agentProfile = new MaiaAgentProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IBehaviourFactory, BehaviourFactory)
			putImplementation(ILifecycleScheme, FipaLifecycleScheme)
			putImplementation(ILifecycleService, LifecycleService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val behaviourProfile = new MaiaBehaviourProfile => [
			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(ILifecycleScheme, FipaLifecycleScheme)
			putImplementation(ILifecycleService, LifecycleService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		context => [
			registerService(MaiaRootContextProfile, rootProfile, null)
			registerService(MaiaContainerProfile, containerProfile, null)
			registerService(MaiaAgentProfile, agentProfile, null)
			registerService(MaiaBehaviourProfile, behaviourProfile, null)
		]
	}

	override stop(BundleContext context) throws Exception {
		Activator.context = null
	}

}
