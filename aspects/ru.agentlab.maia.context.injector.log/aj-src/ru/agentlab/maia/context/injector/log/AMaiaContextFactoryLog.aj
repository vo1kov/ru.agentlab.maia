package ru.agentlab.maia.context.injector.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.aj.AMaiaContextFactory;

public aspect AMaiaContextFactoryLog extends AMaiaContextFactory {

	before(IMaiaContextFactory factory, IMaiaContext parent, String name) : 
		onCreateChildContext(factory, parent, name) {
		Logger logger = LoggerFactory.getLogger(factory.getClass());
		logger.info("Try to create [" + name + "] context with [" + parent
				+ "] parent...");
	}
	
	after(IMaiaContextFactory factory, String name) returning: 
		onCreateChildContext(factory, *, name) {
		Logger logger = LoggerFactory.getLogger(factory.getClass());
		logger.info("Context [" + name + "] successfully created");
	}

	after(IMaiaContextFactory factory, String name) returning: 
		onCreateContext(factory, name) {
		Logger logger = LoggerFactory.getLogger(factory.getClass());
		logger.info("Context [" + name + "] successfully created");
	}
}