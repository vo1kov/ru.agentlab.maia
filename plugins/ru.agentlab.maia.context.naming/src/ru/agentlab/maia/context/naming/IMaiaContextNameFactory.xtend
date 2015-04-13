package ru.agentlab.maia.context.naming

/**
 * Service for name generating.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextNameFactory {
	
	val static String KEY_NAME = "ru.agentlab.maia.name"

	/**
	 * Generate new name.
	 * 
	 * @return Generated name
	 */
	def String createName()

}