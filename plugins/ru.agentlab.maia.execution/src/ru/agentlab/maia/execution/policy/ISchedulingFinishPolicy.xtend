package ru.agentlab.maia.execution.policy

import ru.agentlab.maia.execution.tree.IExecutionScheduler

interface ISchedulingFinishPolicy {

	def void onEnd(IExecutionScheduler scheduler)

}