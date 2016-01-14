package ru.agentlab.maia.behaviour.aspect;

import ru.agentlab.maia.IBehaviourScheduler;

public abstract aspect AMaiaExecutorScheduler {

	pointcut add() : 
		execution(* IBehaviourScheduler+.add(..));

	pointcut remove() : 
		execution(* IBehaviourScheduler+.remove(..));

	pointcut nextContext() : 
		execution(* IBehaviourScheduler+.getNextContext(..));

}