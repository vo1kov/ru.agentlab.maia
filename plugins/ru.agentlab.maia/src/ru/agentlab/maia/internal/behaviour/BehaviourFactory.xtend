package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.naming.IBehaviourNameGenerator

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	@Inject
	IEclipseContext context

	def private getTickerProperties(Class<?> contributorClass) {
		for (method : contributorClass.methods) {
			for (annotation : method.annotations) {
				if (annotation instanceof ActionTicker) {
					return context.createChild => [
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

	override createDefault(IEclipseContext root, String id) {
		val context = root.createEmpty(id)

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
		return context
	}

	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new empty Behaviour...")
		LOGGER.debug("	Behaviour Id: [{}]", id)

		LOGGER.info("Prepare Behaviour root context...")
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.info("Root context is null, get it from OSGI services...")
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
		val context = rootContext.createChild("Behaviour [" + name + "] Context") => [
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, "ru.agentlab.maia.behaviour")
		]

		LOGGER.info("Empty Behaviour successfully created!")
		return context
	}

	def private void addContextProperty(IEclipseContext context, String key, Object value) {
		LOGGER.debug("	Put Property [{}] with vale [{}]  to context...", key, value)
		context.set(key, value)
	}

	def private <T> void addContextService(IEclipseContext context, Class<T> key, T value) {
		LOGGER.debug("	Put Service [{}] with vale [{}]  to context...", key, value)
		context.set(key, value)
	}

}