package ru.agentlab.maia.context

/**
 * Factory for creating Contexts.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextFactory {

	/**
	 * Create Context without any additional services
	 * @return Context without any additional services
	 */
	def IMaiaContext createContext()

}