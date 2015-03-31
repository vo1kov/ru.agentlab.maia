package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.behaviour.BehaviourNotFoundException
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.service.IServiceManagementService

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourNameGenerator behaviourNameGenerator

	def private getTickerProperties(Class<?> contributorClass) {
		for (method : contributorClass.methods) {
			for (annotation : method.annotations) {
				if (annotation instanceof ActionTicker) {
					return EclipseContextFactory.create => [
						set("period", annotation.period)
						set("fixedPeriod", annotation.fixedPeriod)
						it.parent = null
					]
				}
			}
		}
	}

	def private String getBehaviourType(Class<?> contributorClass) {
		for (method : contributorClass.methods) {
			for (annotation : method.annotations) {
				if (annotation instanceof Action) {
					return annotation.type
				}
			}
		}
		return null
	}

	override createDefault(String id) {
		LOGGER.info("Try to create new Default Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_DEFAULT)
		createBehaviour(Behaviour, null)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override IEclipseContext createCyclyc(String id) {
		LOGGER.info("Try to create new Cyclyc Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_CYCLYC)
		createBehaviour(BehaviourCyclyc, null)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override IEclipseContext createOneShot(String id) {
		LOGGER.info("Try to create new One Shot Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_ONE_SHOT)
		createBehaviour(BehaviourOneShot, null)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override createTicker(String id, long delay) {
		LOGGER.info("Try to create new Ticker Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		val properties = EclipseContextFactory.create => [
			set("period", delay)
			set("fixedPeriod", true)
		]
		result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_TICKER)
		createBehaviour(BehaviourTicker, properties)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override createFromAnnotation(String id, Class<?> contributorClass) {
		LOGGER.info("Try to create new Behaviour from Annotation...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		val type = contributorClass.getBehaviourType

		switch (type) {
			case IBehaviour.TYPE_ONE_SHOT: {
				result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_ONE_SHOT)
				createBehaviour(BehaviourOneShot, null)
			}
			case IBehaviour.TYPE_CYCLYC: {
				result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_CYCLYC)
				createBehaviour(BehaviourCyclyc, null)
			}
			case IBehaviour.TYPE_TICKER: {
				result.set(IBehaviour.KEY_TYPE, IBehaviour.TYPE_TICKER)
				val properties = contributorClass.getTickerProperties
				createBehaviour(BehaviourTicker, properties)
			}
			default: {
				throw new BehaviourNotFoundException("Behaviour Action with id " + id + " not found")
			}
		}

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

	def private IBehaviour createBehaviour(Class<? extends IBehaviour> behaviourClass, IEclipseContext local) {
		LOGGER.info("Create {} instance...", behaviourClass.simpleName)
		val behaviour = ContextInjectionFactory.make(behaviourClass, context, local)
		ContextInjectionFactory.invoke(behaviour, PostConstruct, context, null)
		context.set(IBehaviour, behaviour)
		context.runAndTrack(new BehaviourInstaller)
		return behaviour
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
			declareModifiable(IContributionService.KEY_CONTRIBUTOR)
		]

		LOGGER.info("Add properties to Context...")
		context.get(IServiceManagementService) => [
			addService(result, KEY_NAME, name)
			addService(result, KEY_TYPE, TYPE_BEHAVIOUR)
		]

		LOGGER.info("Add link for parent Context...")
		var behaviours = context.get(KEY_BEHAVIOURS) as List<IEclipseContext>
		if (behaviours == null) {
			LOGGER.debug("	Parent Context [{}] have no behaviours link, create new list...", context)
			behaviours = new ArrayList<IEclipseContext>
			context.set(KEY_BEHAVIOURS, behaviours)
		}
		behaviours += result
		return result
	}

}