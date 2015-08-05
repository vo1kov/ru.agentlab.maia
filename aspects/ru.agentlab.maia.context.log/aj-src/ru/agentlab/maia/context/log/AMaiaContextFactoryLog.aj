package ru.agentlab.maia.context.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.context.IMaiaContext;
import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.aj.AMaiaContextFactory;

public aspect AMaiaContextFactoryLog extends AMaiaContextFactory {

	after(IMaiaContextFactory factory) returning (IMaiaContext result): 
		onCreateContext(factory) {
		Logger logger = LoggerFactory.getLogger(factory.getClass());
		logger.info("Context [" + result.getUuid() + "] successfully created");
	}
}