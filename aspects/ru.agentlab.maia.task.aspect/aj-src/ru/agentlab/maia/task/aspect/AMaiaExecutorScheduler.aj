package ru.agentlab.maia.task.aspect;

import ru.agentlab.maia.task.ITaskScheduler;

public abstract aspect AMaiaExecutorScheduler {

	pointcut add() : 
		execution(* ITaskScheduler+.add(..));

	pointcut remove() : 
		execution(* ITaskScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* ITaskScheduler+.getNextContext(..));

}