package ru.agentlab.maia.context.injector.event;

import ru.agentlab.maia.context.pointcut.AbstractContextFactoryAspect;

public aspect ContextEvent extends AbstractContextFactoryAspect {

	before() : onChildCreate() {
		System.err.println("Before createChild Context");
	}

}
