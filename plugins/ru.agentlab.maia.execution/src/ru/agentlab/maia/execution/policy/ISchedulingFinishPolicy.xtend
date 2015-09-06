package ru.agentlab.maia.execution.policy

import ru.agentlab.maia.execution.tree.IExecutionScheduler
import ru.agentlab.maia.memory.IMaiaContext

interface ISchedulingFinishPolicy {

	def void onEnd(IMaiaContext context, IExecutionScheduler scheduler)

}