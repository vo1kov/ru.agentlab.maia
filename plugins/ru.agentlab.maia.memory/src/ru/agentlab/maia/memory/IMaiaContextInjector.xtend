package ru.agentlab.maia.memory

import java.lang.annotation.Annotation
import java.lang.reflect.Method
import ru.agentlab.maia.memory.exception.MaiaInjectionException

/**
 * <p>
 * Service for injection context to objects.
 * </p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextInjector {

	/**
	 * <p>
	 * Obtain an instance of the specified class and inject it with the context. 
	 * Class'es scope dictates if a new instance of the class will be created, 
	 * or existing instance will be reused. 
	 * </p>
	 * 
	 * @param clazz 	the class to be instantiated
	 * @param T 		type of creating service
	 * @return 			an instance of the specified class
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def <T> T make(Class<T> clazz) throws MaiaInjectionException

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * If no matching method is found on the class, an InjectionException will be thrown. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param qualifier the annotation tagging method to be called
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Class<? extends Annotation> ann) throws MaiaInjectionException

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * If no matching method is found on the class, the defaultValue will be returned. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param qualifier the annotation tagging method to be called
	 * @param defaultValue a value to be returned if the method cannot be called, might be null
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Class<? extends Annotation> qualifier,
		Object defaultValue) throws MaiaInjectionException

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param methodName the name of method to be called
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def void invoke(Object object, String methodName)

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * If throws some exception while invoke method, the defaultValue will be returned. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param methodName the name of method to be called
	 * @param defaultValue a value to be returned if the method cannot be called, might be null
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def void invoke(Object object, String methodName, Object defaultValue)

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param method	the method to be called
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Method method)

	/**
	 * <p>
	 * Call a method, injecting the parameters from the context. 
	 * If throws some exception while invoke method, the defaultValue will be returned. 
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @param method	the method to be called
	 * @param defaultValue a value to be returned if the method cannot be called, might be null
	 * @return 			the return value of the method call, might be null
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def Object invoke(Object object, Method method, Object defaultValue)

	/**
	 * <p>
	 * Injects a context into a domain object.
	 * </p>
	 * 
	 * @param object 	the object to perform injection on
	 * @throws 			MaiaInjectionException 
	 * 					if an exception occurred while performing this operation
	 */
	def void inject(Object object) throws MaiaInjectionException

	/**
	 * <p>
	 * Create new service instance and register it to context
	 * </p>
	 * 
	 * @param clazz 	type of service to be deployed
	 * @return 			deployed service object
	 * @param T 		type of deployed service
	 * @throws 			MaiaInjectionException 
	 * 					when creating or registering falls
	 */
	def <T> T deploy(Class<T> clazz) throws MaiaInjectionException

	/**
	 * <p>
	 * Create new service instance and register it to context with specified key
	 * </p>
	 * 
	 * @param clazz 	type of service to be deployed
	 * @param key 		key for registration in context
	 * @param T 		type of deployed service
	 * @return 			deployed service object
	 * @throws 			MaiaInjectionException 
	 * 					when creating or registering falls
	 */
	def <T> T deploy(Class<T> clazz, String key) throws MaiaInjectionException

	/**
	 * <p>
	 * Create new service instance and register it to context with specified key
	 * </p>
	 * 
	 * @param clazz 	type of service to be deployed
	 * @param interf 	interface for registration in context
	 * @param T 		type of deployed service
	 * @return 			deployed service object
	 * @throws 			MaiaInjectionException 
	 * 					when creating or registering falls
	 */
	def <T> T deploy(Class<? extends T> clazz, Class<T> interf) throws MaiaInjectionException

	/**
	 * <p>
	 * Inject context to service object and register it to context
	 * </p>
	 * 
	 * @param service 	service object to be deployed
	 * @param T 		type of deployed service
	 * @return  		deployed service object
	 * @throws 			MaiaInjectionException 
	 * 					when injecting falls
	 */
	def <T> T deploy(T service) throws MaiaInjectionException

	/**
	 * <p>
	 * Inject context to service object and register it to context with specified key
	 * </p>
	 * 
	 * @param service	service object to be deployed
	 * @param key 		key for registration in context
	 * @param T 		type of deployed service
	 * @return  		deployed service object
	 * @throws 			MaiaInjectionException 
	 * 					when creating or registering falls
	 */
	def <T> T deploy(T service, String key) throws MaiaInjectionException

	/**
	 * <p>
	 * Inject context to service object and register it to context with specified key
	 * </p>
	 * 
	 * @param service 	service object to be deployed
	 * @param interf 	interface for registration in context
	 * @param T 		type of deployed service
	 * @return 			deployed service object
	 * @throws 			MaiaInjectionException 
	 * 					when creating or registering falls
	 */
	def <T> T deploy(T service, Class<T> interf) throws MaiaInjectionException
}