package ru.agentlab.maia.context.injector.e4.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.injector.e4.E4MaiaContext;

public aspect ContextLog {
	
	before() : execution(IMaiaContext IMaiaContextFactory+.createChild(..)) {
		Logger logger = LoggerFactory.getLogger(thisJoinPoint.getTarget().getClass());
		logger.info("Before createChild LOG");
	}
	

	before() : execution(* E4MaiaContext.dump(..)) {
		System.err.println("Before DUMP");
	}
	
}
