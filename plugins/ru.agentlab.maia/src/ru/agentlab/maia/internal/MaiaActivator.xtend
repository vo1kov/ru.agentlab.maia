package ru.agentlab.maia.internal

import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.service.event.EventAdmin
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.behaviour.sheme.IBehaviourPropertyMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourSchemeRegistry
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMappingFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.container.IContainerIdFactory
import ru.agentlab.maia.context.IProfile
import ru.agentlab.maia.initializer.IInitializerService
import ru.agentlab.maia.internal.agent.AgentFactory
import ru.agentlab.maia.internal.agent.AgentIdFactory
import ru.agentlab.maia.internal.agent.LocalAgentRegistry
import ru.agentlab.maia.internal.agent.Scheduler
import ru.agentlab.maia.internal.agent.SchedulerFactory
import ru.agentlab.maia.internal.behaviour.Behaviour
import ru.agentlab.maia.internal.behaviour.BehaviourFactory
import ru.agentlab.maia.internal.behaviour.BehaviourPropertyMapping
import ru.agentlab.maia.internal.behaviour.BehaviourTaskMapping
import ru.agentlab.maia.internal.behaviour.BehaviourTaskMappingFactory
import ru.agentlab.maia.internal.behaviour.PropertyIndex
import ru.agentlab.maia.internal.behaviour.scheme.BehaviourSchemeRegistry
import ru.agentlab.maia.internal.behaviour.scheme.impl.BehaviourSchemeCyclic
import ru.agentlab.maia.internal.behaviour.scheme.impl.BehaviourSchemeOneShot
import ru.agentlab.maia.internal.behaviour.scheme.impl.BehaviourSchemeTicker
import ru.agentlab.maia.internal.container.ContainerFactory
import ru.agentlab.maia.internal.container.ContainerIdFactory
import ru.agentlab.maia.internal.context.Profile
import ru.agentlab.maia.internal.initializer.InitializerService
import ru.agentlab.maia.internal.io.ClientFactory
import ru.agentlab.maia.internal.io.ServerFactory
import ru.agentlab.maia.internal.lifecycle.LifecycleService
import ru.agentlab.maia.internal.lifecycle.scheme.FipaLifecycleScheme
import ru.agentlab.maia.internal.messaging.AclMessageFactory
import ru.agentlab.maia.internal.messaging.ArrayBlockingMessageQueue
import ru.agentlab.maia.internal.messaging.ArrayBlockingMessageQueueFactory
import ru.agentlab.maia.internal.messaging.netty.NettyMessageDeliveryService
import ru.agentlab.maia.internal.messaging.netty.NettyMessageDeliveryServiceFactory
import ru.agentlab.maia.internal.naming.AgentNameGenerator
import ru.agentlab.maia.internal.naming.BehaviourNameGenerator
import ru.agentlab.maia.internal.naming.ContainerNameGenerator
import ru.agentlab.maia.internal.naming.PlatformNameGenerator
import ru.agentlab.maia.internal.platform.PlatformFactory
import ru.agentlab.maia.internal.platform.PlatformIdFactory
import ru.agentlab.maia.internal.service.ServiceManagementService
import ru.agentlab.maia.io.IClientFactory
import ru.agentlab.maia.io.IServerFactory
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.scheme.ILifecycleScheme
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.naming.IPlatformNameGenerator
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformIdFactory
import ru.agentlab.maia.service.IServiceManagementService

class MaiaActivator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	def IProfile getDefaultProfile() {
		return new Profile => [
			set(IClientFactory, ClientFactory)
			set(IServerFactory, ServerFactory)

			set(IContainerNameGenerator, ContainerNameGenerator)
			set(IContainerIdFactory, ContainerIdFactory)
			set(IContainerFactory, ContainerFactory)
			set(IInitializerService, InitializerService)

			set(IMessageDeliveryService, NettyMessageDeliveryService)
			set(IMessageDeliveryServiceFactory, NettyMessageDeliveryServiceFactory)

			set(IPlatformIdFactory, PlatformIdFactory)
			set(IMessageQueueFactory, ArrayBlockingMessageQueueFactory)
			set(IAgentNameGenerator, AgentNameGenerator)
			set(IAgentIdFactory, AgentIdFactory)
			set(ISchedulerFactory, SchedulerFactory)
			set(IMessageQueueFactory, ArrayBlockingMessageQueueFactory)
			set(IMessageFactory, AclMessageFactory)
			set(IAgentFactory, AgentFactory)
			set(IInitializerService, InitializerService)

			set(IBehaviourPropertyMapping, BehaviourPropertyMapping)
			set(PropertyIndex, PropertyIndex)

			set(IBehaviourNameGenerator, BehaviourNameGenerator)
			set(IBehaviourFactory, BehaviourFactory)

			set(ILifecycleScheme, FipaLifecycleScheme)
			set(ILifecycleService, LifecycleService)

			set(IScheduler, Scheduler)
			set(IMessageQueue, ArrayBlockingMessageQueue)

			set(IInitializerService, InitializerService)

			set(IBehaviourTaskMappingFactory, BehaviourTaskMappingFactory)
			set(IBehaviourTaskMapping, BehaviourTaskMapping)
			set(IBehaviour, Behaviour)
		]
	}

	def IBehaviourSchemeRegistry getDefaultBehaviourSchemeRegistry() {
		return new BehaviourSchemeRegistry => [
			defaultScheme = new BehaviourSchemeOneShot
			schemes += defaultScheme
			schemes += new BehaviourSchemeCyclic
			schemes += new BehaviourSchemeTicker
		]
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = bundleContext

		EclipseContextFactory.getServiceContext(context) => [
			val oldProfile = get(IProfile)
			if (oldProfile == null) {
				set(IProfile, defaultProfile)
			} else {
				defaultProfile.keys.forEach [ key |
					oldProfile.mergeOption(key)
				]
			}

//			set(IInitializerService.name, new InitializerFunction)
			set(IBehaviourSchemeRegistry, defaultBehaviourSchemeRegistry)
			createService(context, IServiceManagementService, ServiceManagementService)
//			createService(context, IMessageDeliveryServiceFactory, NettyMessageDeliveryServiceFactory)
			createService(context, IPlatformIdFactory, PlatformIdFactory)
			createService(context, IPlatformNameGenerator, PlatformNameGenerator)
			createService(context, IPlatformFactory, PlatformFactory)

			createService(context, LocalAgentRegistry, LocalAgentRegistry)
		]
	}

	def <T> void mergeOption(IProfile profile, Class<T> interf) {
		val oldValue = profile.get(interf)
		if (oldValue == null) {
			val newValue = defaultProfile.get(interf)
			profile.set(interf, newValue)
		} else {
			// Do nothing, use old value
		}
	}

	def private <T> void createService(IEclipseContext context, BundleContext bundleContext, Class<T> serviceClass,
		Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, context)
		ContextInjectionFactory.invoke(service, PostConstruct, context, null)
		context.set(serviceClass, service)
		bundleContext.registerService(serviceClass, service, null)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		MaiaActivator.context = null
	}

	def static EventAdmin getEventAdmin() {
	}

}
