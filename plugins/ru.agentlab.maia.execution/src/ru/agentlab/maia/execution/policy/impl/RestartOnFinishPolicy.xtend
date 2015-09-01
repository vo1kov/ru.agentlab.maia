package ru.agentlab.maia.execution.policy.impl

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.policy.ISchedulingFinishPolicy
import ru.agentlab.maia.execution.tree.IExecutionScheduler

class RestartOnFinishPolicy implements ISchedulingFinishPolicy {

	override onEnd(IMaiaContext context, IExecutionScheduler scheduler) {
		scheduler.activate
	}

}