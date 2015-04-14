package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaContextSchedulerFactory {

	def IMaiaContextScheduler createScheduler(IMaiaContext context)

}