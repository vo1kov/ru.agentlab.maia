package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaExecutorScheduler {

	def IMaiaContext getNextContext()
	
	def void remove(IMaiaContext context)

	def void removeAll()

}