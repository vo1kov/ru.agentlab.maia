package ru.agentlab.maia.context.typing.agent

import ru.agentlab.maia.context.IMaiaContext

/**
 * Factory for creating new Agents.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaAgentContextFactory {

	def IMaiaContext createAgent(IMaiaContext parentContext)

}