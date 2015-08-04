package ru.agentlab.maia.profile.defaults.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.behaviour.scheme.lib.BehaviourSchemeOneShot
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.context.initializer.MaiaContextInitializerService
import ru.agentlab.maia.context.typing.agent.IMaiaAgentContextFactory
import ru.agentlab.maia.context.typing.agent.MaiaAgentContextFactory
import ru.agentlab.maia.context.typing.agent.MaiaAgentProfile
import ru.agentlab.maia.context.typing.behaviour.IMaiaBehaviourContextFactory
import ru.agentlab.maia.context.typing.behaviour.MaiaBehaviourContextFactory
import ru.agentlab.maia.context.typing.behaviour.MaiaBehaviourProfile
import ru.agentlab.maia.context.typing.container.IMaiaContainerContextFactory
import ru.agentlab.maia.context.typing.container.MaiaContainerContextFactory
import ru.agentlab.maia.context.typing.container.MaiaContainerProfile
import ru.agentlab.maia.context.typing.root.MaiaRootContextProfile
import ru.agentlab.maia.execution.IMaiaExecutorService
import ru.agentlab.maia.execution.MaiaExecutorService
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleScheme
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleService
import ru.agentlab.maia.execution.lifecycle.LifecycleService
import ru.agentlab.maia.execution.lifecycle.fipa.FipaLifecycleScheme
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool
import ru.agentlab.maia.execution.pool.cached.MaiaCachedExecutorPool
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.scheme.IMaiaExecutorSchedulerScheme
import ru.agentlab.maia.execution.scheduler.scheme.SchemeScheduler
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

class Activator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	override start(BundleContext context) throws Exception {
		Activator.context = context

		val rootProfile = new MaiaRootContextProfile => [
//			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContainerContextFactory, MaiaContainerContextFactory)
			putImplementation(IMaiaExecutorPool, MaiaCachedExecutorPool)
		]

		val containerProfile = new MaiaContainerProfile => [
//			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaAgentContextFactory, MaiaAgentContextFactory)
//			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
//			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val agentProfile = new MaiaAgentProfile => [
//			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaBehaviourContextFactory, MaiaBehaviourContextFactory)
			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaExecutorScheduler, SequenceContextScheduler)
			putImplementation(IMaiaExecutorService, MaiaExecutorService)
			putImplementation(IMaiaContextInitializerService, MaiaContextInitializerService)
		]

		val behaviourProfile = new MaiaBehaviourProfile => [
//			putImplementation(IMaiaContextNameFactory, UuidNameGenerator)
			putImplementation(IMaiaContextLifecycleScheme, FipaLifecycleScheme)
			putImplementation(IMaiaContextLifecycleService, LifecycleService)
			putImplementation(IMaiaExecutorSchedulerScheme, BehaviourSchemeOneShot)
			putImplementation(IMaiaExecutorScheduler, SchemeScheduler)
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
