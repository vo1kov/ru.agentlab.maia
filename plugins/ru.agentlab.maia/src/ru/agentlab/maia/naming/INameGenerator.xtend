package ru.agentlab.maia.naming

import org.eclipse.e4.core.contexts.IEclipseContext

/**
 * Service for name generating.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface INameGenerator {
	
	/**
	 * Generate new name.
	 * 
	 * @param context - context for generating names. Can be used to provide a unique name.
	 * @return Generated name
	 */
	def String generate(IEclipseContext context)
	
}