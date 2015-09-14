package ru.agentlab.maia.memory

import java.util.Collection
import java.util.Set
import javax.inject.Provider

/**
 * <p>
 * Context for storage services and objects.
 * </p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContext {

	val static String KEY_TYPE = "ru.agentlab.maia.context._type"

	/**
	 * <p>
	 * Returns parent of context or <code>null</code> if context is a root context.
	 * </p>
	 * 
	 * @return 			parent of context or <code>null</code> if context have no parent.
	 */
	def IMaiaContext getParent()

	/**
	 * <p>
	 * Change parent of context. If <code>null</code> then context become to 
	 * be a root context.
	 * </p>
	 * 
	 * @param parent 	the new parent context. If <code>null</code> then context
	 * 					become to be a root context.
	 */
	def void setParent(IMaiaContext parent)

	/**
	 * <p>
	 * Returns collection of context childs. 
	 * </p>
	 * 
	 * @return 			collection of context childs.
	 */
	def Collection<IMaiaContext> getChilds()

	/**
	 * <p>
	 * Register specified context as a child. 
	 * </p>
	 * 
	 * @param child 	context registering as a child of context.
	 */
	def void addChild(IMaiaContext child)

	/**
	 * <p>
	 * Deregister specified context from childs. 
	 * </p>
	 * 
	 * @param child 	context deregistering from child contexts.
	 */
	def void removeChild(IMaiaContext child)

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
	 * @param name		the name of the value to return.
	 * @return			an object corresponding to the given name, or <code>null</code>.
	 * 
	 * @see #getService(Class)
	 */
	def Object getService(String name) throws NullPointerException

	/**
	 * <p>
	 * Returns the context value associated with the given name. Returns <code>null</code> if no
	 * such value is defined or computable by this context, or if the assigned value is
	 * <code>null</code>.
	 * </p>
	 * 
	 * @param clazz		the class that needs to be found in the context
	 * @param T 		type of returning value
	 * @return			an object corresponding to the given class, or <code>null</code>
	 * 
	 * @see #getService(String)
	 */
	def <T> T getService(Class<T> clazz) throws NullPointerException, ClassCastException

	/**
	 * <p>
	 * Returns the context value associated with the given name in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * </p><p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * 
	 * @param name 		the name of the value to return
	 * @param T 		type of returning value
	 * @return 			an object corresponding to the given name, or <code>null</code>
	 * 
	 * @see #getServiceLocal(Class)
	 */
	def Object getServiceLocal(String name) throws NullPointerException

	/**
	 * <p>
	 * Returns the context value associated with the given class in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * </p><p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * 
	 * @param clazz		the class of the value to return
	 * @param T 		type of returning value
	 * @return 			an object corresponding to the given class, or <code>null</code>
	 * 
	 * @see #getServiceLocal(String)
	 */
	def <T> T getServiceLocal(Class<T> clazz) throws NullPointerException, ClassCastException

	def Provider<?> getProvider(String name) throws NullPointerException

	def <T> Provider<T> getProvider(Class<T> clazz) throws NullPointerException, ClassCastException

	def Provider<?> getProviderLocal(String name) throws NullPointerException

	def <T> Provider<T> getProviderLocal(Class<T> clazz) throws NullPointerException, ClassCastException

	/**
	 * <p>
	 * Returns <code>true</code> if context contains a value for the specified key. 
	 * </p><p>
	 * Depending on the implementation of context the <code>contains()</code>
	 * method invoke can be less complex than <code>get()</code> invoke. 
	 * Therefore for testing that context have value better to use <code>contains()</code>
	 * method rather than <code>get()</code> and compare returning value to null. 
	 * </p>
	 * 
	 * @param clazz		the class that needs to be found in the context
	 * @return			context containing value for <code>clazz</code> key. 
	 * 					It can be self or one of parent context or <code>null</code> 
	 * 					if hierarchy of contexts have no value for specified key.
	 * 
	 * @see #contains(String)
	 */
	def IMaiaContext contains(Class<?> clazz) throws NullPointerException

	/**
	 * <p>
	 * Returns <code>true</code> if context contains a value for the specified key. 
	 * </p><p>
	 * Depending on the implementation of context the <code>contains()</code>
	 * method invoke can be less complex than <code>get()</code> invoke. 
	 * Therefore for testing that context have value better to use <code>contains()</code>
	 * method rather than <code>get()</code> and compare returning value to null. 
	 * </p>
	 * 
	 * @param name		the name of the value that needs to be found in the context
	 * @return			context containing value for <code>clazz</code> key. It can be self or 
	 * 					one of parent context or <code>null</code> if hierarchy of contexts 
	 * 					have no value for specified key.
	 * 
	 * @see #contains(Class)
	 */
	def IMaiaContext contains(String name) throws NullPointerException

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
	 * @param name 		the name to remove
	 * @return 			value removed from context 
	 * 
	 * @see #remove(Class)
	 */
	def Object remove(String name) throws NullPointerException

	/**
	 * <p>
	 * Removes the given name and any corresponding value from this context.
	 * </p><p>
	 * Removal can never affect a parent context, so it is possible that a subsequent call to
	 * {@link #get(String)} with the same name will return a non-null result, due to a value being
	 * stored in a parent context.
	 * </p>
	 * 
	 * @param clazz 	the class to remove
	 * @return 			value removed from context 
	 * 
	 * @see #remove(String)
	 */
	def Object remove(Class<?> clazz) throws NullPointerException

	def boolean clear()

	/**
	 * <p>
	 * Sets a value to be associated with a given name in this context. 
	 * The value can may be <code>null</code>.
	 * </p>
	 * 
	 * @param name 		the name to store a value for. Can not be <code>null</code>.
	 * 					If <code>null</code> than NullPointerException will be thrown.
	 * @param value 	the value to be stored that can return the stored value.
	 * 
	 * @see #putService(Class, Object)
	 */
	def void putService(String name, Object value) throws NullPointerException

	/**
	 * <p>
	 * Sets a value to be associated with a given class in this context.
	 * </p>
	 * 
	 * @param clazz 	the class to store a value for
	 * @param value 	the value to be stored
	 * @param T 		type of specified value
	 * 
	 * @see #putService(String, Object)
	 * @see #putProvider(String, Provider)
	 */
	def <T> void putService(Class<T> clazz, T value) throws NullPointerException, ClassCastException

	/**
	 * <p>
	 * Sets a value to be associated with a given {@link Provider} in this context.
	 * Value can obtain lazily. The value may be <code>null</code>.
	 * </p>
	 * 
	 * @param name 		the class to store a value for
	 * @param provider 	provider of value to be stored
	 * 
	 * @see #putProvider(Class, Provider)
	 */
	def void putProvider(String name, Provider<?> provider) throws NullPointerException

	/**
	 * <p>
	 * Sets a value to be associated with a given {@link Provider} in this context.
	 * </p>
	 * 
	 * @param clazz 	the class to store a value for
	 * @param provider 	provider of value to be stored
	 * @param T 		type of specified value
	 * 
	 * @see #putProvider(String, Provider)
	 */
	def <T> void putProvider(Class<T> clazz, Provider<T> provider) throws NullPointerException, ClassCastException

}