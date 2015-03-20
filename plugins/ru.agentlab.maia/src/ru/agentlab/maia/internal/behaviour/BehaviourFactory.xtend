package ru.agentlab.maia.internal.behaviour

import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory

class BehaviourFactory implements IBehaviourFactory {

	override create(IAgent agent, String id, Class<?> contributorClass) {

		val context = agent.context

		// Prepare Behaviour Context
		val behaviourContext = context.createChild("Behaviour [" + id + "] Context") => [
			set(IBehaviour.KEY_NAME, id)
			set(IBehaviour.KEY_STATE, IBehaviour.STATE_READY)
		]
		// Create Behaviour instance in Context
		val behaviour = ContextInjectionFactory.make(Behaviour, behaviourContext)
		try {
			ContextInjectionFactory.invoke(behaviour, PostConstruct, behaviourContext)
		} catch (Exception e) {
		}
		behaviourContext.set(IBehaviour, behaviour)

		// Create Agent Contributor in Context
		val contributor = ContextInjectionFactory.make(contributorClass, behaviourContext)
		try {
			ContextInjectionFactory.invoke(contributor, PostConstruct, behaviourContext)
		} catch (Exception e) {
		}

		return behaviour
	}

}