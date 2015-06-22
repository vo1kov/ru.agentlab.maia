package ru.agentlab.maia.context.injector.event;

import ru.agentlab.maia.context.pointcut.AbstaractContextInjectorAspect;

public aspect ContextEvent extends AbstaractContextInjectorAspect {

	before() : onChildCreate() {
		System.err.println("Before createChild Context");
	}

}
