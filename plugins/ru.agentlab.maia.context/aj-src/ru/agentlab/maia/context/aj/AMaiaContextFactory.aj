package ru.agentlab.maia.context.aj;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.IMaiaContextFactory;

/**
 * Abstract aspect with pointcuts of {@link IMaiaContextFactory} methods
 * 
 * @author Shishkin Dmitriy
 *
 */
public abstract aspect AMaiaContextFactory {

	/**
	 * When actual IMaiaContextFactory object is created
	 */
	public pointcut onConstruct() : 
		execution(IMaiaContextFactory+.new(..));

	/**
	 * When {@link IMaiaContextFactory} begin to create new child
	 * {@link IMaiaContext}
	 * 
	 * @param factory
	 *            - factory that create new context
	 * @param parent
	 *            - parent context for newly created context
	 * @param name
	 *            - name for new context
	 */
	public pointcut onCreateChildContext(IMaiaContextFactory factory,
			IMaiaContext parent, String name) : 
		execution(IMaiaContext IMaiaContextFactory+.createChild(IMaiaContext, String)) && 
		target(factory) && 
		args(parent, name);

	/**
	 * When {@link IMaiaContextFactory} begin to create new {@link IMaiaContext}
	 * 
	 * @param factory
	 *            - factory that create new context
	 * @param name
	 *            - name for new context
	 */
	public pointcut onCreateContext(IMaiaContextFactory factory, String name) : 
		execution(IMaiaContext IMaiaContextFactory+.createContext(String)) && 
		target(factory) && 
		args(name);

}