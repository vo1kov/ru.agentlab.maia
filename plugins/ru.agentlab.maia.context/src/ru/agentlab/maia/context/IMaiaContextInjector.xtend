package ru.agentlab.maia.context

import java.lang.annotation.Annotation
import ru.agentlab.maia.context.exception.MaiaInjectionException

/**
 * Service for injection context to objects.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextInjector {

	/**
	 * Obtain an instance of the specified class and inject it with the context. 
	 * Class'es scope dictates if a new instance of the class will be created, 
	 * or existing instance will be reused. 
	 * 
	 * @param 
	 * 		clazz - The class to be instantiated
	 * @return 
	 * 		An instance of the specified class
	 * @throws 
	 * 		MaiaInjectionException if an exception occurred while performing this operation
	 */
	def <T> T make(Class<T> clazz) throws MaiaInjectionException

	/**
	 * Call a method, injecting the parameters from the context. 
	 * If no matching method is found on the class, an InjectionException will be thrown. 
	 * 
	 * @param 
	 * 		object - The object to perform injection on
	 * @param 
	 * 		qualifier - The annotation tagging method to be called
	 * @return 
	 * 		The return value of the method call, might be null
	 * @throws 
	 * 		MaiaInjectionException if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Class<? extends Annotation> ann) throws MaiaInjectionException

	/**
	 * Call a method, injecting the parameters from the context. 
	 * If no matching method is found on the class, the defaultValue will be returned. 
	 * 
	 * @param 
	 * 		object - The object to perform injection on
	 * @param 
	 * 		qualifier - The annotation tagging method to be called
	 * @param 
	 * 		defaultValue - A value to be returned if the method cannot be called, might be null
	 * @return 
	 * 		The return value of the method call, might be null
	 * @throws 
	 * 		MaiaInjectionException if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Class<? extends Annotation> qualifier,
		Object defaultValue) throws MaiaInjectionException

	/**
	 * Injects a context into a domain object.
	 * 
	 * @param 
	 * 		object - The object to perform injection on
	 * @throws 
	 * 		MaiaInjectionException if an exception occurred while performing this operation
	 */
	def void inject(Object object) throws MaiaInjectionException

}