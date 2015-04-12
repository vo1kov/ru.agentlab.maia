package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.IMaiaContext

interface ISchedulerFactory {

	def IScheduler createScheduler(IMaiaContext context)

}