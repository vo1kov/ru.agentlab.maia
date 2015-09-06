package ru.agentlab.maia.memory

/**
 * Factory for creating Contexts.
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextFactory {

	/**
	 * Create Context without any additional services
	 * 
	 * @return 
	 * 		Context without any additional services
	 */
	def IMaiaContext createContext()

}