package ru.agentlab.maia.context.log;

import static ru.agentlab.maia.memory.context.logs.Messages.AFTER_CREATE_CONTEXT;
import static ru.agentlab.maia.memory.context.logs.Messages.getMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.agentlab.maia.memory.IMaiaContext;
import ru.agentlab.maia.memory.IMaiaContextFactory;
import ru.agentlab.maia.memory.aj.AMaiaContextFactory;

public aspect AMaiaContextFactoryLog extends AMaiaContextFactory {

	after(IMaiaContextFactory factory) returning (IMaiaContext result): 
		onCreateContext(factory) {
		Logger logger = LoggerFactory.getLogger(factory.getClass());
		getMessage(AFTER_CREATE_CONTEXT, result.getUuid());
		logger.info("Context [" + result.getUuid() + "] successfully created");
	}
}