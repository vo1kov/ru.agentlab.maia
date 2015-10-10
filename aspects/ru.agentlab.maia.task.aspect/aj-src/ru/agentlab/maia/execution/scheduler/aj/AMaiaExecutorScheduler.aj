package ru.agentlab.maia.execution.scheduler.aj;

import ru.agentlab.maia.execution.ITaskScheduler;

public abstract aspect AMaiaExecutorScheduler {

	pointcut add() : 
		execution(* ITaskScheduler+.add(..));

	pointcut remove() : 
		execution(* ITaskScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* ITaskScheduler+.getNextContext(..));

}