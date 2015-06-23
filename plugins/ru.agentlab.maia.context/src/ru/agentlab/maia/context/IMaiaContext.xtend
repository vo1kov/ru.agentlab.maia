package ru.agentlab.maia.context

interface IMaiaContext {

	val public static String KEY_PARENT_CONTEXT = "ru.agentlab.maia.context|parent.context"

	val public static String KEY_CHILD_CONTEXTS = "ru.agentlab.maia.context|child.context"

	def public IMaiaContext getParent()

	def public Iterable<IMaiaContext> getChilds()

	/**
	 * Returns the context value associated with the given name. Returns <code>null</code> if no
	 * such value is defined or computable by this context, or if the assigned value is
	 * <code>null</code>.
	 * <p>
	 * If the value associated with this name is an {@link ContextFunction}, this method will
	 * evaluate {@link ContextFunction#compute(IEclipseContext, String)}.
	 * </p>
	 * @param name the name of the value to return
	 * @return an object corresponding to the given name, or <code>null</code>
	 */
	def Object get(String name)

	/**
	 * Returns the context value associated with the given class.
	 * @param clazz the class that needs to be found in the context
	 * @return an object corresponding to the given class, or <code>null</code>
	 * @see #get(String)
	 */
	def <T> T get(Class<T> clazz)

	/**
	 * Returns the context value associated with the given name in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * <p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * <p>
	 * If the value associated with this name is an {@link ContextFunction}, this method will
	 * evaluate {@link ContextFunction#compute(IEclipseContext, String)}.
	 * </p>
	 * @param name the name of the value to return
	 * @return an object corresponding to the given name, or <code>null</code>
	 */
	def Object getLocal(String name);

	/**
	 * Returns the context value associated with the given class in this context, or <code>null</code> if 
	 * no such value is defined in this context.
	 * <p>
	 * This method does not search for the value on other elements on the context tree.
	 * </p>
	 * @param clazz The class of the value to return
	 * @return An object corresponding to the given class, or <code>null</code>
	 * @see #getLocal(String)
	 */
	def <T> T getLocal(Class<T> clazz);

	/**
	 * Removes the given name and any corresponding value from this context.
	 * <p>
	 * Removal can never affect a parent context, so it is possible that a subsequent call to
	 * {@link #get(String)} with the same name will return a non-null result, due to a value being
	 * stored in a parent context.
	 * </p>
	 * @param name the name to remove
	 */
	def void remove(String name);

	/**
	 * Removes the value for the given class from this context.
	 * @param clazz The class to remove
	 * @see #remove(String)
	 */
	def void remove(Class<?> clazz);

	/**
	 * Sets a value to be associated with a given name in this context. The value may be an
	 * arbitrary object, or it may be an {@link ContextFunction}. In the case of a function,
	 * subsequent invocations of {@link #get(String)} with the same name will invoke
	 * {@link ContextFunction#compute(IEclipseContext, String)} to obtain the value. The value
	 * may be <code>null</code>.
	 * <p>
	 * Removal can never affect a parent context, so it is possible that a subsequent call to
	 * {@link #get(String)} with the same name will return a non-null result, due to a value being
	 * stored in a parent context.
	 * </p>
	 * @param name the name to store a value for
	 * @param value the value to be stored, or a {@link ContextFunction} that can return 
	 * the stored value.
	 */
	def void set(String name, Object value);

	/**
	 * Sets a value to be associated with a given class in this context. 
	 * @param clazz The class to store a value for
	 * @param value The value to be stored
	 * @see #set(String, Object)
	 */
	def <T> void set(Class<T> clazz, T value);

	/**
	 * For internal temporal usage only.
	 * Do not use in production.
	 */
	@Deprecated
	def String dump()

}