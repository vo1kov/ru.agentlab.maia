package ru.agentlab.maia.naming

/**
 * Service for name generating.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface INameGenerator {

	/**
	 * Generate new name.
	 * 
	 * @return Generated name
	 */
	def String generate()

}