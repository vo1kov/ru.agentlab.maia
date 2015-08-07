package ru.agentlab.maia.context

import ru.agentlab.maia.context.exception.MaiaDeploymentException

/**
 * Service for deploying services to context.
 */
interface IMaiaServiceDeployer {

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