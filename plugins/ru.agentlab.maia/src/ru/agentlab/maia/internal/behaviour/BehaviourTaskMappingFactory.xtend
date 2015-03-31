package ru.agentlab.maia.internal.behaviour

import ru.agentlab.maia.behaviour.IBehaviourTaskMappingFactory

class BehaviourTaskMappingFactory implements IBehaviourTaskMappingFactory {

	override create() {
		return new BehaviourTaskMapping
	}

}