package ru.agentlab.maia.execution.scheduler.aj;

import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler;

public abstract aspect AMaiaExecutorScheduler {

	pointcut add() : 
		execution(* IMaiaExecutorScheduler+.add(..));

	pointcut remove() : 
		execution(* IMaiaExecutorScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* IMaiaExecutorScheduler+.getNextContext(..));
	
}