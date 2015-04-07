package org.maia.task.scheduler.scheme.internal.mapping

import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMappingFactory

class BehaviourTaskMappingFactory implements IBehaviourTaskMappingFactory {

	override create() {
		return new BehaviourTaskMapping
	}

}