package ru.agentlab.maia.execution.policy

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.tree.IExecutionScheduler

interface ISchedulingFinishPolicy {

	def void onEnd(IMaiaContext context, IExecutionScheduler scheduler)

}