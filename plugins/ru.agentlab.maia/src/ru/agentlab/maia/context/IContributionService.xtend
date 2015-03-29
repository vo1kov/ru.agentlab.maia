package ru.agentlab.maia.context

import org.eclipse.e4.core.contexts.IEclipseContext

/**
 * Service for add Contributors in context.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IContributionService {
	
	/**
	 * Key for store Contributor in Context
	 */
	val static String KEY_CONTRIBUTOR = "context.contributor"
	
	/**
	 * Add new Contributor in context
	 * @param context - context where new contributor will be created. This context will 
	 * be used for injecting objects. 
	 * @param contributorClass - class of contributor to be created.
	 */
	def void addContributor(IEclipseContext context, Class<?> contributorClass)

}