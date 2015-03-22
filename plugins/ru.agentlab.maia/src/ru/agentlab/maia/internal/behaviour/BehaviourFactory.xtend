package ru.agentlab.maia.internal.behaviour

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.behaviour.BehaviourNotFoundException
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory

class BehaviourFactory implements IBehaviourFactory {

	@Inject
	IEclipseContext context

	override create(IAgent agent, String id, Class<?> contributorClass) {
		val context = agent.context

		// Prepare Behaviour Context
		val behaviourContext = context.createChild("Behaviour [" + id + "] Context") => [
			set(IBehaviour.KEY_NAME, id)
			set(IBehaviour.KEY_STATE, IBehaviour.STATE_READY)
		]

		// Create Behaviour instance in Context
		val type = contributorClass.getBehaviourType

		val behaviour = switch (type) {
			case IBehaviour.TYPE_ONE_SHOT: {
				ContextInjectionFactory.make(BehaviourOneShot, behaviourContext)
			}
			case IBehaviour.TYPE_CYCLYC: {
				ContextInjectionFactory.make(BehaviourCyclyc, behaviourContext)
			}
			case IBehaviour.TYPE_TICKER: {
				val properties = contributorClass.getTickerProperties
				ContextInjectionFactory.make(BehaviourTicker, behaviourContext, properties)
			}
			default: {
				throw new BehaviourNotFoundException("Behaviour Action with id " + id + " not found")
			}
		}

		ContextInjectionFactory.invoke(behaviour, PostConstruct, behaviourContext, null)
		behaviourContext.set(IBehaviour, behaviour)

		// Create Behaviour Contributor in Context
		if(contributorClass != null){
			val contributor = ContextInjectionFactory.make(contributorClass, behaviourContext)
			behaviourContext.set(IBehaviour.KEY_CONTRIBUTOR, contributor)
			ContextInjectionFactory.invoke(contributor, PostConstruct, behaviourContext, null)
		}

		return behaviour
	}

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

}