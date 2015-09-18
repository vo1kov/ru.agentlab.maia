package ru.agentlab.maia.execution.policy.impl

import ru.agentlab.maia.execution.policy.ISchedulingFinishPolicy
import ru.agentlab.maia.execution.tree.IExecutionScheduler

class DeleteOnFinishPolicy implements ISchedulingFinishPolicy {

	override onEnd(IExecutionScheduler scheduler) {
		scheduler.parent.removeChild(scheduler)
	}

}