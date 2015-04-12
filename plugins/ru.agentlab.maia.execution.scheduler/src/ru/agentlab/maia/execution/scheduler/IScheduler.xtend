package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.IMaiaContext

interface IScheduler {

	def IMaiaContext getNextContext()

}