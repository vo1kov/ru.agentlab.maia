package ru.agentlab.maia.initializer

import org.eclipse.e4.core.contexts.IEclipseContext

/**
 * Service for add Initializer in context.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IInitializerService {

	/**
	 * Key for store Initializer in Context
	 */
	val static String KEY_INITIALIZER = "context.initializer"

	/**
	 * Add new Initializer in context.
	 * 
	 * @param InitializerClass - class of Initializer to be created.
	 * @return Newly created Initializer
	 */
	def Object addInitializer(Class<?> initializerClass)

	/**
	 * Add new Initializer in context.
	 * 
	 * @param context - context where new Initializer will be created. This context will 
	 * be used for injecting objects. 
	 * @param InitializerClass - class of Initializer to be created.
	 * @return Newly created Initializer
	 */
	def Object addInitializer(IEclipseContext context, Class<?> initializerClass)

}