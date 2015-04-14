package ru.agentlab.maia.agent

import ru.agentlab.maia.context.IMaiaContext

/**
 * Factory for creating new Agents.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IAgentFactory {

	def IMaiaContext createAgent(IMaiaContext parentContext)

}