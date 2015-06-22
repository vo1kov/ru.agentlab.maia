package ru.agentlab.maia.context.injector.log;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.IMaiaContext;

public aspect ContextLog {
	
	before() : execution(IMaiaContext IMaiaContextFactory+.createChild(..)) {
		getLogger(thisJoinPoint).info("Before createChild LOG");
	}
	

	before() : execution(* IMaiaContext+.dump(..)) {
		getLogger(thisJoinPoint).info("Before DUMP");
	}
	
	protected Logger getLogger(JoinPoint point){
		return LoggerFactory.getLogger(point.getTarget().getClass());
	}
	
}
