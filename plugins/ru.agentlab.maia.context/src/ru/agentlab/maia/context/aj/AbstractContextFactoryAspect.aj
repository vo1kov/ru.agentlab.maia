package ru.agentlab.maia.context.aj;

import ru.agentlab.maia.context.IMaiaContextFactory;

public abstract aspect AbstractContextFactoryAspect {

	public pointcut onCreateChildContext() : 
		execution(* IMaiaContextFactory+.createChild(..));

	public pointcut onCreateContext() : 
		execution(* IMaiaContextFactory+.createContext(..));

}