package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.naming.IBehaviourNameGenerator

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	extension ContextExtension = new ContextExtension(LOGGER)

	def private getTickerProperties(Class<?> contributorClass) {
		for (method : contributorClass.methods) {
			for (annotation : method.annotations) {
				if (annotation instanceof ActionTicker) {
//					return context.createChild => [
//						set("period", annotation.period)
//						set("fixedPeriod", annotation.fixedPeriod)
//						it.parent = null
//					]
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

	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Default Behaviour...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

//		// Create Behaviour instance in Context
//		val type = contributorClass.getBehaviourType
//
//		val behaviour = switch (type) {
//			case IBehaviour.TYPE_ONE_SHOT: {
//				ContextInjectionFactory.make(BehaviourOneShot, behaviourContext)
//			}
//			case IBehaviour.TYPE_CYCLYC: {
//				ContextInjectionFactory.make(BehaviourCyclyc, behaviourContext)
//			}
//			case IBehaviour.TYPE_TICKER: {
//				val properties = contributorClass.getTickerProperties
//				ContextInjectionFactory.make(BehaviourTicker, behaviourContext, properties)
//			}
//			default: {
//				throw new BehaviourNotFoundException("Behaviour Action with id " + id + " not found")
//			}
//		}
//
//		ContextInjectionFactory.invoke(behaviour, PostConstruct, behaviourContext, null)
//		behaviourContext.set(IBehaviour, behaviour)
//
//		agent.scheduler.add(behaviour)
		LOGGER.info("Behaviour successfully created!")
		return context
	}

	override IEclipseContext createCyclyc(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Cyclyc Behaviour...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Create Behaviour instance...")
		context.createBehaviour(null, BehaviourCyclyc)

		LOGGER.info("Behaviour successfully created!")
		return context
	}

	override IEclipseContext createOneShot(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Cyclyc Behaviour...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Create Behaviour instance...")
		context.createBehaviour(null, BehaviourOneShot)

		LOGGER.info("Behaviour successfully created!")
		return context
	}
	
	override createTicker(IEclipseContext root, String id, long delay) {
		LOGGER.info("Try to create new Cyclyc Behaviour...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Create Behaviour instance...")
		val properties = EclipseContextFactory.create => [
			set("period", delay)
			set("fixedPeriod", true)
		]
		context.createBehaviour(properties, BehaviourTicker)

		LOGGER.info("Behaviour successfully created!")
		return context
	}
	
	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Empty Behaviour...")
		LOGGER.debug("	root context: [{}]", root)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val context = internalCreateEmpty(root, id)

		LOGGER.info("Behaviour successfully created!")
		return context
	}

	def private IBehaviour createBehaviour(IEclipseContext context, IEclipseContext local,
		Class<? extends IBehaviour> behaviourClass) {
		LOGGER.info("Create {} instance...", behaviourClass.simpleName)
		val behaviour = ContextInjectionFactory.make(behaviourClass, context, local)
		ContextInjectionFactory.invoke(behaviour, PostConstruct, context, null)
		context.set(IBehaviour, behaviour)

		LOGGER.info("Add Behaviour to agent scheduler...")
		val scheduler = context.parent.get(IScheduler)
		if (scheduler != null) {
			scheduler.add(behaviour)
		} else {
			LOGGER.info("Root context [{}] have no scheduler", context.parent)
		}
		return behaviour
	}

	private def internalCreateEmpty(IEclipseContext root, String id) {
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.warn("Root context is null, get it from OSGI services...")
				EclipseContextFactory.getServiceContext(MaiaActivator.getContext)
			}

		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Behaviour Name...")
				val nameGenerator = rootContext.get(IBehaviourNameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Behaviour Name is [{}]", n)
				n
			}

		LOGGER.info("Create Behaviour Context...")
		val context = rootContext.createChild("Context for Behaviour: " + name) => [
			declareModifiable(KEY_BEHAVIOURS)
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, TYPE_BEHAVIOUR)
		]

		LOGGER.info("Add link for parent Context...")
		var behaviours = rootContext.get(KEY_BEHAVIOURS) as List<IEclipseContext>
		if (behaviours == null) {
			LOGGER.debug("	Parent Context [{}] have no behaviours link, create new list...", rootContext)
			behaviours = new ArrayList<IEclipseContext>
			rootContext.set(KEY_BEHAVIOURS, behaviours)
		}
		behaviours += context
		context
	}

}