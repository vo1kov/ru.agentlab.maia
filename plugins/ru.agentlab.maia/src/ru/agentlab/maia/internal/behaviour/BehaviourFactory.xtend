package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.internal.context.ContributionService
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.service.IServiceManagementService
import ru.agentlab.maia.behaviour.IBehaviourScheme
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourTaskMapping

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourNameGenerator behaviourNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

//	def private getTickerProperties(Class<?> contributorClass) {
//		for (method : contributorClass.methods) {
//			for (annotation : method.annotations) {
//				if (annotation instanceof ActionTicker) {
//					return EclipseContextFactory.create => [
//						set("period", annotation.period)
//						set("fixedPeriod", annotation.fixedPeriod)
//						it.parent = null
//					]
//				}
//			}
//		}
//	}
//	def private String getBehaviourType(Class<?> contributorClass) {
//		for (method : contributorClass.methods) {
//			for (annotation : method.annotations) {
//				if (annotation instanceof Action) {
//					return annotation.type
//				}
//			}
//		}
//		return null
//	}
	override createDefault(String id) {
		LOGGER.info("Try to create new Default Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		result.createService(IBehaviourScheme, BehaviourSchemeOneShot)
		result.createService(IBehaviour, Behaviour)

		result.runAndTrack(new BehaviourInstaller)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override createEmpty(String id) {
		LOGGER.info("Try to create new Empty Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	private def internalCreateEmpty(String id) {
		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Behaviour Name...")
				behaviourNameGenerator.generate
			}

		LOGGER.info("Create Behaviour Context...")
		val result = context.createChild("Context for Behaviour: " + name) => [
			declareModifiable(KEY_BEHAVIOURS)
			declareModifiable(KEY_NAME)
			declareModifiable(IBehaviourScheme)
			declareModifiable(IBehaviourTaskMapping)
		]

		LOGGER.info("Add properties to Context...")
		context.get(IServiceManagementService) => [
			addService(result, KEY_NAME, name)
		]

		LOGGER.info("Add link for parent Context...")
		var behaviours = context.get(KEY_BEHAVIOURS) as List<IEclipseContext>
		if (behaviours == null) {
			LOGGER.debug("	Parent Context [{}] have no behaviours link, create new list...", context)
			behaviours = new ArrayList<IEclipseContext>
			context.set(KEY_BEHAVIOURS, behaviours)
		}
		behaviours += result

		result.createService(IContributionService, ContributionService)
		return result
	}

	def private <T> void createService(IEclipseContext ctx, Class<T> serviceClass,
		Class<? extends T> implementationClass) {
		val service = ContextInjectionFactory.make(implementationClass, ctx)
		ContextInjectionFactory.invoke(service, PostConstruct, ctx, null)
		serviceManagementService.addService(ctx, serviceClass, service)
	}

}