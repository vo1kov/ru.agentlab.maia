package ru.agentlab.maia.context.injector.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.IMaiaContext;

public aspect ContextLog {
	
	before() : execution(IMaiaContext IMaiaContextFactory+.createChild(..)) {
		Logger logger = LoggerFactory.getLogger(thisJoinPoint.getTarget().getClass());
		logger.info("Before createChild LOG");
	}
	

	before() : execution(* IMaiaContext+.dump(..)) {
		System.err.println("Before DUMP");
	}
	
}
