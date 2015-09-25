package ru.agentlab.maia.execution.scheduler.aj;

import ru.agentlab.maia.execution.IExecutionScheduler;

public abstract aspect AMaiaExecutorScheduler {

	pointcut add() : 
		execution(* IExecutionScheduler+.add(..));

	pointcut remove() : 
		execution(* IExecutionScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* IExecutionScheduler+.getNextContext(..));

}