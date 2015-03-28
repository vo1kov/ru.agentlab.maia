package ru.agentlab.maia.internal

import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.IAgentNameGenerator
import ru.agentlab.maia.agent.IFipaAgentLifecycleService
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.container.IContainerNameGenerator
import ru.agentlab.maia.internal.agent.AgentFactory
import ru.agentlab.maia.internal.agent.AgentIdFactory
import ru.agentlab.maia.internal.agent.AgentNameGenerator
import ru.agentlab.maia.internal.agent.FipaAgentLifecycleService
import ru.agentlab.maia.internal.agent.SchedulerFactory
import ru.agentlab.maia.internal.behaviour.BehaviourFactory
import ru.agentlab.maia.internal.container.ContainerFactory
import ru.agentlab.maia.internal.container.ContainerIdFactory
import ru.agentlab.maia.internal.container.ContainerNameGenerator
import ru.agentlab.maia.internal.messaging.MessageFactory
import ru.agentlab.maia.internal.messaging.MessageQueueFactory
import ru.agentlab.maia.internal.platform.PlatformFactory
import ru.agentlab.maia.internal.platform.PlatformIdFactory
import ru.agentlab.maia.internal.platform.PlatformNameGenerator
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformIdFactory
import ru.agentlab.maia.platform.IPlatformNameGenerator

class MaiaActivator implements BundleActivator {

	static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = bundleContext

		context => [
			registerService(ISchedulerFactory, new SchedulerFactory, null)
			registerService(IMessageFactory, new MessageFactory, null)
			registerService(IMessageQueueFactory, new MessageQueueFactory, null)

			registerService(IFipaAgentLifecycleService, new FipaAgentLifecycleService, null)

			registerService(IAgentNameGenerator, new AgentNameGenerator, null)
			registerService(IContainerNameGenerator, new ContainerNameGenerator, null)
			registerService(IPlatformNameGenerator, new PlatformNameGenerator, null)

			registerService(IPlatformIdFactory, new PlatformIdFactory, null)
			registerService(IContainerIdFactory, new ContainerIdFactory, null)
			registerService(IAgentIdFactory, new AgentIdFactory, null)
		]
		var osgiContext = EclipseContextFactory.getServiceContext(bundleContext)

		val platformFactory = ContextInjectionFactory.make(PlatformFactory, osgiContext)
		osgiContext.set(IPlatformFactory, platformFactory)
		context.registerService(IPlatformFactory, platformFactory, null)

		val containerFactory = ContextInjectionFactory.make(ContainerFactory, osgiContext)
		osgiContext.set(IContainerFactory, containerFactory)
		context.registerService(IContainerFactory, containerFactory, null)

		val agentFactory = ContextInjectionFactory.make(AgentFactory, osgiContext)
		osgiContext.set(IAgentFactory, agentFactory)
		context.registerService(IAgentFactory, agentFactory, null)

		val behaviourFactory = ContextInjectionFactory.make(BehaviourFactory, osgiContext)
		osgiContext.set(IBehaviourFactory, behaviourFactory)
		context.registerService(IBehaviourFactory, behaviourFactory, null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = null
	}

}
