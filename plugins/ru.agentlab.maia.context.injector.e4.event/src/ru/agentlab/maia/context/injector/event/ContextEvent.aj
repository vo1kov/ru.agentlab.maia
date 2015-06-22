package ru.agentlab.maia.context.injector.event;

import ru.agentlab.maia.context.IMaiaContextFactory;
import ru.agentlab.maia.context.IMaiaContext;

public aspect ContextEvent {

	before() : execution(IMaiaContext IMaiaContextFactory+.createChild(..)) {
		System.err.println("Before createChild Context");
	}
	

}
