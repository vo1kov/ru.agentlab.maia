package ru.agentlab.maia.execution.scheduler.unbounded

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.IMaiaContextScheduler

interface IMaiaUnboundedContextScheduler extends IMaiaContextScheduler {

	def void add(IMaiaContext context)

}