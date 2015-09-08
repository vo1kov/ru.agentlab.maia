package ru.agentlab.maia.context.injector.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.memory.IMaiaContext;
import ru.agentlab.maia.memory.aj.AMaiaContextFactory;

public aspect AMaiaContextInjectorLog extends AMaiaContextFactory {

//	before(IMaiaContextFactory factory) : 
//		onCreateContext(factory) {
//		Logger logger = LoggerFactory.getLogger(factory.getClass());
//		logger.info("Try to create context...");
//	}
//
//	after(IMaiaContextFactory factory) returning (IMaiaContext result): 
//		onCreateContext(factory) {
//		Logger logger = LoggerFactory.getLogger(factory.getClass());
//		logger.info("Context [" + result.getUuid() + "] successfully created");
//	}
}