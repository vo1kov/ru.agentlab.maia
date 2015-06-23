package ru.agentlab.maia.context.aj;

import ru.agentlab.maia.context.IMaiaContext;

/**
 * Abstract aspect with pointcuts of {@link IMaiaContext} methods
 * 
 * @author Shishkin Dmitriy
 *
 */
public abstract aspect AMaiaContext {

	/**
	 * When actual IMaiaContext object is created
	 */
	public pointcut onConstruct() : 
		execution(IMaiaContext+.new(..));

	/**
	 * When {@link IMaiaContext} get service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetByString(IMaiaContext context, String id) : 
		execution(Object IMaiaContext+.get(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} get service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetByClass(IMaiaContext context, Class<?> id) : 
		execution(Object IMaiaContext+.get(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} set service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByString(IMaiaContext context, String id, Object obj) : 
		execution(void IMaiaContext+.set(String, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IMaiaContext} set service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByClass(IMaiaContext context, Class<?> id,
			Object obj) : 
		execution(void IMaiaContext+.set(Class, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IMaiaContext} get service object locally by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetLocalByString(IMaiaContext context, String id) : 
		execution(Object IMaiaContext+.getLocal(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} get service object locally by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetLocalByClass(IMaiaContext context, Class<?> id) : 
		execution(Object IMaiaContext+.getLocal(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} remove service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service to be removed
	 */
	public pointcut onRemoveByString(IMaiaContext context, String id) : 
		execution(void IMaiaContext+.remove(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} remove service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onRemoveByClass(IMaiaContext context, Class<?> id) : 
		execution(void IMaiaContext+.remove(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IMaiaContext} retrieve all it's childs contexts
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetChilds(IMaiaContext context) : 
		execution(Iterable<IMaiaContext>  IMaiaContext+.getChilds()) && 
		target(context);

	/**
	 * When {@link IMaiaContext} retrieve parent context
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetParent(IMaiaContext context) : 
		execution(IMaiaContext IMaiaContext+.getParent(..)) && 
		target(context);

}