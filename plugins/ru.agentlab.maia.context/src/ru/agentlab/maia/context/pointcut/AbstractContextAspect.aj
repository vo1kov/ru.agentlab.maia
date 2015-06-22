package ru.agentlab.maia.context.pointcut;

import ru.agentlab.maia.context.IMaiaContext;

public aspect AbstractContextAspect {
	
	public pointcut onGet() : 
		execution(* IMaiaContext+.get(..));

	public pointcut onGetByString() : 
		execution(* IMaiaContext+.get(String));

	public pointcut onGetByClass() : 
		execution(* IMaiaContext+.get(Class));
	
}
