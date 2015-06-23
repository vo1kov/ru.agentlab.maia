package ru.agentlab.maia.context.aj;

import ru.agentlab.maia.context.IMaiaContext;

public aspect AbstractContextAspect {

	public pointcut onGet() : 
		execution(* IMaiaContext+.get(..)) || 
		execution(* IMaiaContext+.getLocal(..));

	public pointcut onSet() : 
		execution(* IMaiaContext+.set(..));

	public pointcut onGetLocal() : 
		execution(* IMaiaContext+.getLocal(..));

	public pointcut onRemove() : 
		execution(* IMaiaContext+.remove(..));

	public pointcut onGetChilds() : 
		execution(* IMaiaContext+.getChilds(..));

	public pointcut onGetParent() : 
		execution(* IMaiaContext+.getParent(..));

}