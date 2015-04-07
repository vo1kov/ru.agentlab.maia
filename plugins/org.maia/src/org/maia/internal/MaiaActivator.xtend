package org.maia.internal

import com.google.common.util.concurrent.AbstractScheduledService.Scheduler
import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IAgentFactory
import org.maia.IBehaviourFactory
import org.maia.IContainerFactory
import org.maia.IPlatformFactory
import org.maia.IProfile
import org.maia.behaviour.scheduler.IScheduler
import org.maia.behaviour.scheduler.ISchedulerFactory
import org.maia.initializer.IInitializerService
import org.maia.internal.initializer.InitializerService
import org.maia.internal.naming.UuidNameGenerator
import org.maia.internal.service.ServiceManagementService
import org.maia.lifecycle.ILifecycleService
import org.maia.lifecycle.scheme.ILifecycleScheme
import org.maia.messaging.IMessageDeliveryService
import org.maia.messaging.IMessageDeliveryServiceFactory
import org.maia.messaging.IMessageFactory
import org.maia.messaging.queue.IMessageQueue
import org.maia.messaging.queue.IMessageQueueFactory
import org.maia.naming.IAgentNameGenerator
import org.maia.naming.IBehaviourNameGenerator
import org.maia.naming.IContainerNameGenerator
import org.maia.naming.IPlatformNameGenerator
import org.maia.service.IServiceManagementService
import org.maia.task.scheduler.IBehaviour
import org.maia.task.scheduler.scheme.IBehaviourSchemeRegistry
import org.maia.task.scheduler.scheme.internal.BehaviourSchemeRegistry
import org.maia.task.scheduler.scheme.internal.PropertyIndex
import org.maia.task.scheduler.scheme.internal.mapping.BehaviourPropertyMapping
import org.maia.task.scheduler.scheme.internal.mapping.BehaviourTaskMapping
import org.maia.task.scheduler.scheme.internal.mapping.BehaviourTaskMappingFactory
import org.maia.task.scheduler.scheme.mapping.IBehaviourPropertyMapping
import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMapping
import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMappingFactory
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.service.event.EventAdmin

class MaiaActivator implements BundleActivator {

	static BundleContext context

	def static BundleContext getContext() {
		return context
	}

	def IProfile getDefaultProfile() {
		return new Profile => [
			set(IClientFactory, ClientFactory)
			set(IServerFactory, ServerFactory)

			set(IContainerNameGenerator, UuidNameGenerator)
			set(IContainerFactory, ContainerFactory)
			set(IInitializerService, InitializerService)

			set(IMessageDeliveryService, NettyMessageDeliveryService)
			set(IMessageDeliveryServiceFactory, NettyMessageDeliveryServiceFactory)

			set(IMessageQueueFactory, ArrayBlockingMessageQueueFactory)
			set(IAgentNameGenerator, UuidNameGenerator)
			set(ISchedulerFactory, SchedulerFactory)
			set(IMessageQueueFactory, ArrayBlockingMessageQueueFactory)
			set(IMessageFactory, AclMessageFactory)
			set(IAgentFactory, AgentFactory)
			set(IInitializerService, InitializerService)

			set(IBehaviourPropertyMapping, BehaviourPropertyMapping)
			set(PropertyIndex, PropertyIndex)

			set(IBehaviourNameGenerator, UuidNameGenerator)
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
			createService(context, IPlatformNameGenerator, UuidNameGenerator)
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
