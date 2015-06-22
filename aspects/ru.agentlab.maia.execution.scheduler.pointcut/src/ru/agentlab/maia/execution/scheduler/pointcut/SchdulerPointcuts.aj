package ru.agentlab.maia.execution.scheduler.pointcut;

import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler;

public aspect SchdulerPointcuts {

	pointcut add() : 
		execution(* IMaiaExecutorScheduler+.add(..));

	pointcut remove() : 
		execution(* IMaiaExecutorScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* IMaiaExecutorScheduler+.getNextContext(..));
	
}
