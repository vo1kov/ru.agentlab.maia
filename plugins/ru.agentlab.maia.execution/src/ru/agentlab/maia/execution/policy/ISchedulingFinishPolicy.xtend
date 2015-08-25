package ru.agentlab.maia.execution.policy

import ru.agentlab.maia.context.IMaiaContext

interface ISchedulingFinishPolicy {

	def void onEnd(IMaiaContext context)

}