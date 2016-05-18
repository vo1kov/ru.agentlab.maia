package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public abstract class AbstractRoleBaseEvent extends Event<Class<?>> {

	public AbstractRoleBaseEvent(Class<?> role) {
		super(role);
	}

}
