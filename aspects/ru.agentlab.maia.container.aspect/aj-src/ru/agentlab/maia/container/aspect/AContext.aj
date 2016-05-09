package ru.agentlab.maia.container.aspect;

import ru.agentlab.maia.IContainer;

/**
 * Abstract aspect with pointcuts of {@link IContainer} methods
 * 
 * @author Shishkin Dmitriy
 *
 */
public abstract aspect AContext {

	/**
	 * When actual {@link IContainer} object is created
	 */
	public pointcut onConstruct() : 
		execution(IContainer+.new(..));

	/**
	 * When {@link IContainer} get service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetByString(IContainer context, String id) : 
		execution(Object IContainer+.getService(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} get service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetByClass(IContainer context, Class<?> id) : 
		execution(Object IContainer+.getService(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} set service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByString(IContainer context, String id, Object obj) : 
		execution(void IContainer+.putService(String, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IContainer} set service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 * @param obj
	 *            - service object
	 */
	public pointcut onSetByClass(IContainer context, Class<?> id,
			Object obj) : 
		execution(void IContainer+.putService(Class, Object)) && 
		target(context) && 
		args(id, obj);

	/**
	 * When {@link IContainer} get service object locally by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service
	 */
	public pointcut onGetLocalByString(IContainer context, String id) : 
		execution(Object IContainer+.getServiceLocal(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} get service object locally by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onGetLocalByClass(IContainer context, Class<?> id) : 
		execution(Object IContainer+.getServiceLocal(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} remove service object by string identifier
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - string identifier of context service to be removed
	 */
	public pointcut onRemoveByString(IContainer context, String id) : 
		execution(void IContainer+.remove(String)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} remove service object by it's type
	 * 
	 * @param context
	 *            - current context
	 * @param id
	 *            - type of context service
	 */
	public pointcut onRemoveByClass(IContainer context, Class<?> id) : 
		execution(void IContainer+.remove(Class)) && 
		target(context) && 
		args(id);

	/**
	 * When {@link IContainer} retrieve all it's childs contexts
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetChilds(IContainer context) : 
		execution(Iterable<IContainer>  IContainer+.getChilds()) && 
		target(context);

	/**
	 * When {@link IContainer} retrieve parent context
	 * 
	 * @param context
	 *            - current context
	 */
	public pointcut onGetParent(IContainer context) : 
		execution(IContainer IContainer+.getParent(..)) && 
		target(context);

}