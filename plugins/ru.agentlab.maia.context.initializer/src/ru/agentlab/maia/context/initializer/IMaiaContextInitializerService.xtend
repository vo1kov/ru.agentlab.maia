package ru.agentlab.maia.context.initializer

/**
 * Service for add Initializer in context.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextInitializerService {

	/**
	 * Key for store Initializer in Context
	 */
	val static String KEY_INITIALIZER = "ru.agentlab.maia.context.initializer|object.value"

	/**
	 * Add new Initializer in context.
	 * 
	 * @param InitializerClass - class of Initializer to be created.
	 * @return Newly created Initializer
	 */
	def <T> T addInitializer(Class<T> InitializerClass)

}