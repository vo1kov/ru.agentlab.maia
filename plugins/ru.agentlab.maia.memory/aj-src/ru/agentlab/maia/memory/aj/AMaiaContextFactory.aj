package ru.agentlab.maia.memory.aj;

import ru.agentlab.maia.memory.IMaiaContext;
import ru.agentlab.maia.memory.IMaiaContextFactory;

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
	 * When {@link IMaiaContextFactory} begin to create new {@link IMaiaContext}
	 * 
	 * @param factory
	 *            - factory that create new context
	 * @param name
	 *            - name for new context
	 */
	public pointcut onCreateContext(IMaiaContextFactory factory) : 
		execution(IMaiaContext IMaiaContextFactory+.createContext()) && 
		target(factory) && 
		args();

}