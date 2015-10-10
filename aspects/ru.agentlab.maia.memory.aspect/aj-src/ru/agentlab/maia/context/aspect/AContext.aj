package ru.agentlab.maia.context.aspect;

import ru.agentlab.maia.context.IContext;

/**
 * Abstract aspect with pointcuts of {@link IContext} methods
 * 
 * @author Shishkin Dmitriy
 *
 */
public abstract aspect AContext {

	/**
	 * When actual {@link IContext} object is created
	 */
	public pointcut onConstruct() : 
		execution(IContext+.new(..));

	/**
	 * When {@link IContext} get service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetByString(IContext context, String id) : 
		execution(Object IContext+.getService(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} get service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetByClass(IContext context, Class<?> id) : 
		execution(Object IContext+.getService(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} set service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByString(IContext context, String id, Object obj) : 
		execution(void IContext+.putService(String, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IContext} set service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByClass(IContext context, Class<?> id,
			Object obj) : 
		execution(void IContext+.putService(Class, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IContext} get service object locally by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetLocalByString(IContext context, String id) : 
		execution(Object IContext+.getServiceLocal(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} get service object locally by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetLocalByClass(IContext context, Class<?> id) : 
		execution(Object IContext+.getServiceLocal(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} remove service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service to be removed
	 */
	public pointcut onRemoveByString(IContext context, String id) : 
		execution(void IContext+.remove(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} remove service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onRemoveByClass(IContext context, Class<?> id) : 
		execution(void IContext+.remove(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContext} retrieve all it's childs contexts
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetChilds(IContext context) : 
		execution(Iterable<IContext>  IContext+.getChilds()) && 
		target(context);

	/**
	 * When {@link IContext} retrieve parent context
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetParent(IContext context) : 
		execution(IContext IContext+.getParent(..)) && 
		target(context);

}