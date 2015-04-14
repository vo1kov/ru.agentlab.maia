package ru.agentlab.maia.execution.scheduler.unbounded

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

interface IMaiaUnboundedContextScheduler extends IMaiaExecutorScheduler {

	def void add(IMaiaContext context)

}