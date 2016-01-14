package ru.agentlab.maia

import java.util.Set
import ru.agentlab.maia.context.exception.MaiaInjectionException

/**
 * Container for storing services and agents.
 * 
 * @author Dmitry Shishkin
 */
interface IContainer {

	/**
	 * <p>
	 * Returns parent of context or <code>null</code> if context is a root context.
	 * </p>
	 * 
	 * @return 			parent of context or <code>null</code> if context have no parent.
	 */
	def IContainer getParent()

	def Iterable<IContainer> getChilds()

	def void addChild(IContainer container)

	def void removeChild(IContainer container)

	def void clearChilds()

	/**
	 * <p>
	 * Change parent of context. If <code>null</code> then context become to 
	 * be a root context.
	 * </p>
	 * 
	 * @param parent 	the new parent context. If <code>null</code> then context
	 * 					become to be a root context.
	 */
	def IContainer setParent(IContainer parent)

	/**
	 * <p>
	 * Retrieve unique id of context.
	 * </p>
	 * 
	 * @return 			unique id of context. Can not be null.
	 */
	def String getUuid()

	/**
	 * <p>
	 * Returns the context value associated with the given name. Returns <code>null</code> if no
	 * such value is defined or computable by this context, or if the assigned value is
	 * <code>null</code>.
	 * </p>
	 * 
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @return			an object corresponding to the given name, or <code>null</code>.
	 * @throws			MaiaContextKeyNotFound
	 * 					if context have no value for specified key.
	 * 
	 * @see #getService(Class)
	 */
	def Object get(String key)

	/**
	 * <p>
	 * Returns the context value associated with the given name. Returns <code>null</code> if no
	 * such value is defined or computable by this context, or if the assigned value is
	 * <code>null</code>.
	 * </p>
	 * 
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param <T> 		type of returning value.
	 * @return 			an object corresponding to the given class, can be <code>null</code>.
	 * @throws			ClassCastException
	 * 					if context contains value but with different type.
	 * @throws			MaiaContextKeyNotFound
	 * 					if context have no value for specified key.
	 * 
	 * @see #getService(String)
	 */
	def <T> T get(Class<T> key)

	/**
	 * <p>
	 * Returns the context value associated with the given key in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * </p><p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * 
	 * @param key 		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param <T> 		type of returning value
	 * @return 			an object corresponding to the given name, or <code>null</code>
	 * @throws			MaiaContextKeyNotFound
	 * 					if context have no value for specified key.
	 * 
	 * @see #getServiceLocal(Class)
	 */
	def Object getLocal(String key)

	/**
	 * <p>
	 * Returns the context value associated with the given key in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * </p><p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * 
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param <T> 		type of returning value.
	 * @return 			an object corresponding to the given class, can be <code>null</code>.
	 * @throws			ClassCastException
	 * 					if context contains value but with different type.
	 * @throws			MaiaContextKeyNotFound
	 * 					if context have no value for specified key.
	 * 
	 * @see #getServiceLocal(String)
	 */
	def <T> T getLocal(Class<T> key)

	/**
	 * <p>
	 * Returns keys of registered services. 
	 * </p>
	 * 
	 * @return keys of registered services.
	 */
	def Set<String> getKeySet()

	/**
	 * <p>
	 * Removes the given name and any corresponding value from this context.
	 * </p><p>
	 * Removal can never affect a parent context, so it is possible that a subsequent call to
	 * {@link #get(String)} with the same name will return a non-null result, due to a value being
	 * stored in a parent context.
	 * </p>
	 * 
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @return 			value removed from context 
	 * 
	 * @see #remove(Class)
	 */
	def Object remove(String key)

	/**
	 * <p>
	 * Removes the given name and any corresponding value from this context.
	 * </p><p>
	 * Removal can never affect a parent context, so it is possible that a subsequent call to
	 * {@link #get(String)} with the same name will return a non-null result, due to a value being
	 * stored in a parent context.
	 * </p>
	 * 
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @return 			value removed from context 
	 * 
	 * @see #remove(String)
	 */
	def Object remove(Class<?> key)

	def boolean clear()

	/**
	 * <p>
	 * Sets a value to be associated with a given name in this context. 
	 * The value can may be <code>null</code>.
	 * </p>
	 * 
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param value 	the value to be stored that can return the stored value.
	 * 
	 * @see #putService(Class, Object)
	 */
	def Object put(String key, Object value)

	/**
	 * <p>
	 * Sets a value to be associated with a given class in this context.
	 * </p>
	 * 
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param value 	the value to be stored
	 * @param <T> 		type of specified value.
	 * 
	 * @see #putService(String, Object)
	 * @see #putProvider(String, Provider)
	 */
	def <T> Object put(Class<T> key, T value)

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

//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * If no matching method is found on the class, an InjectionException will be thrown. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param qualifier the annotation tagging method to be called
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, Class<? extends Annotation> ann) throws MaiaInjectionException
//
//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * If no matching method is found on the class, the defaultValue will be returned. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param qualifier the annotation tagging method to be called
//	 * @param defaultValue a value to be returned if the method cannot be called, might be null
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, Class<? extends Annotation> qualifier,
//		Object defaultValue) throws MaiaInjectionException
//
//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param methodName the name of method to be called
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, String methodName)
//
//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * If throws some exception while invoke method, the defaultValue will be returned. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param methodName the name of method to be called
//	 * @param defaultValue a value to be returned if the method cannot be called, might be null
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, String methodName, Object defaultValue)
//
//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param method	the method to be called
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, Method method)
//
//	/**
//	 * <p>
//	 * Call a method, injecting the parameters from the context. 
//	 * If throws some exception while invoke method, the defaultValue will be returned. 
//	 * </p>
//	 * 
//	 * @param object 	the object to perform injection on
//	 * @param method	the method to be called
//	 * @param defaultValue a value to be returned if the method cannot be called, might be null
//	 * @return 			the return value of the method call, might be null
//	 * @throws 			MaiaInjectionException 
//	 * 					if an exception occurred while performing this operation
//	 */
//	def Object invoke(Object object, Method method, Object defaultValue)
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
