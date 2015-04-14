package ru.agentlab.maia.context.agent

import ru.agentlab.maia.context.IMaiaContext

/**
 * Factory for creating new Agents.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextAgentFactory {

	def IMaiaContext createAgent(IMaiaContext parentContext)

}