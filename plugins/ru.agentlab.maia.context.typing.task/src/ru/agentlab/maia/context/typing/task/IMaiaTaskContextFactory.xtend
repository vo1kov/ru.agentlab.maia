package ru.agentlab.maia.context.typing.task

import ru.agentlab.maia.context.IMaiaContext

/**
 * Factory for creating new Agents.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaTaskContextFactory {
	
	val static String TYPE = "task"

	def IMaiaContext createTask()

}