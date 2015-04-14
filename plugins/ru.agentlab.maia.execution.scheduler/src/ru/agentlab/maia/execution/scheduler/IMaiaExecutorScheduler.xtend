package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.context.IMaiaContext

interface IMaiaExecutorScheduler {
	
	val static public String KEY_CURRENT_CONTEXT = "ru.agentlab.maia.execution.scheduler|current.context"

	def IMaiaContext getNextContext()
	
	def void remove(IMaiaContext context)

	def void removeAll()

}