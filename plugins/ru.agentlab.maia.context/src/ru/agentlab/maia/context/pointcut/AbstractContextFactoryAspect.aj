package ru.agentlab.maia.context.pointcut;

import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.IMaiaContext;

public abstract aspect AbstractContextFactoryAspect {

	public pointcut onChildCreate() : 
		execution(IMaiaContext IMaiaContextFactory+.createChild(..));
	
	public pointcut onCreate() : 
		execution(IMaiaContext IMaiaContextFactory+.createContext(..));

}
