package ru.agentlab.maia.context

/**
 * <p>Factory for creating Contexts.</p>
 * <p>Contexts represent platform, container, agent and behaviour objects. Context 
 * can contain layer-specific services for injection.</p> 
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