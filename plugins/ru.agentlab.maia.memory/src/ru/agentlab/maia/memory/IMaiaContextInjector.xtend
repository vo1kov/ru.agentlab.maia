package ru.agentlab.maia.memory

import java.lang.annotation.Annotation
import ru.agentlab.maia.memory.exception.MaiaDeploymentException
import ru.agentlab.maia.memory.exception.MaiaInjectionException

/**
 * Service for injection context to objects.
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
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

	/**
	 * Create new service instance and register it to context
	 * 
	 * @param
	 * 		serviceClass - type of service to be deployed
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when creating or registering falls
	 */
	def <T> T deploy(Class<T> serviceClass) throws MaiaDeploymentException

	/**
	 * Create new service instance and register it to context with specified key
	 * 
	 * @param
	 * 		serviceClass - type of service to be deployed
	 * @param
	 * 		key - key for registration in context
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when creating or registering falls
	 */
	def <T> T deploy(Class<T> serviceClass, String key) throws MaiaDeploymentException

	/**
	 * Create new service instance and register it to context with specified key
	 * 
	 * @param
	 * 		serviceClass - type of service to be deployed
	 * @param
	 * 		serviceInterface - interface for registration in context
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when creating or registering falls
	 */
	def <T> T deploy(Class<? extends T> serviceClass, Class<T> serviceInterface) throws MaiaDeploymentException

	/**
	 * Inject context to service object and register it to context
	 * 
	 * @param
	 * 		service - service object to be deployed
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when injecting falls
	 */
	def Object deploy(Object service) throws MaiaDeploymentException

	/**
	 * Inject context to service object and register it to context with specified key
	 * 
	 * @param
	 * 		serviceClass - type of service to be deployed
	 * @param
	 * 		key - key for registration in context
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when creating or registering falls
	 */
	def Object deploy(Object service, String key) throws MaiaDeploymentException

	/**
	 * Inject context to service object and register it to context with specified key
	 * 
	 * @param
	 * 		serviceClass - type of service to be deployed
	 * @param
	 * 		serviceInterface - interface for registration in context
	 * @return 
	 * 		Deployed service object
	 * @throws
	 * 		MaiaDeploymentException when creating or registering falls
	 */
	def <T> T deploy(T service, Class<T> interf) throws MaiaDeploymentException
}