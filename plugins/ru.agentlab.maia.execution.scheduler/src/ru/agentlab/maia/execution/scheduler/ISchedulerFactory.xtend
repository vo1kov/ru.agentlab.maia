package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.context.IMaiaContext

interface ISchedulerFactory {

	def IScheduler createScheduler(IMaiaContext context)

}