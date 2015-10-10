package ru.agentlab.maia.context

import java.util.Set
import javax.inject.Provider
import ru.agentlab.maia.context.exception.MaiaContextKeyNotFound

/**
 * <p>
 * Context for storage services and objects.
 * </p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IContext {

	val static String KEY_TYPE = "ru.agentlab.maia.context._type"

	/**
	 * <p>
	 * Returns parent of context or <code>null</code> if context is a root context.
	 * </p>
	 * 
	 * @return 			parent of context or <code>null</code> if context have no parent.
	 */
	def IContext getParent()

	/**
	 * <p>
	 * Change parent of context. If <code>null</code> then context become to 
	 * be a root context.
	 * </p>
	 * 
	 * @param parent 	the new parent context. If <code>null</code> then context
	 * 					become to be a root context.
	 */
	def IContext setParent(IContext parent)

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
	def Object getService(String key) throws MaiaContextKeyNotFound

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
	def <T> T getService(Class<T> key) throws MaiaContextKeyNotFound

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
	def Object getServiceLocal(String key) throws MaiaContextKeyNotFound

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
	def <T> T getServiceLocal(Class<T> key) throws MaiaContextKeyNotFound
	
	/**
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 */
	def Provider<?> getProvider(String key) throws MaiaContextKeyNotFound
	
	/**
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param <T> 		type of returning value.
	 */
	def <T> Provider<T> getProvider(Class<T> clazz) throws MaiaContextKeyNotFound
	
	/**
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 */
	def Provider<?> getProviderLocal(String key) throws MaiaContextKeyNotFound
	
	/**
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param <T> 		type of returning value.
	 */
	def <T> Provider<T> getProviderLocal(Class<T> key) throws MaiaContextKeyNotFound

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
	def Object putService(String key, Object value)

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
	def <T> Object putService(Class<T> key, T value)

	/**
	 * <p>
	 * Sets a value to be associated with a given {@link Provider} in this context.
	 * Value can obtain lazily. The value may be <code>null</code>.
	 * </p>
	 * 
	 * @param key		key of registered service as plain string. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param provider 	provider of value to be stored
	 * 
	 * @see #putProvider(Class, Provider)
	 */
	def Object putProvider(String key, Provider<?> provider)

	/**
	 * <p>
	 * Sets a value to be associated with a given {@link Provider} in this context.
	 * </p>
	 * 
	 * @param key		key of registered service as type of the value to return. If <code>null</code>
	 * 					then IllegalArgumentException will be thrown.
	 * @param provider 	provider of value to be stored.
	 * @param <T> 		type of specified value
	 * 
	 * @see #putProvider(String, Provider)
	 */
	def <T> Object putProvider(Class<T> key, Provider<T> provider)

}