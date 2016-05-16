package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public abstract class RoleBaseEvent extends Event<Class<?>> {

	public RoleBaseEvent(Class<?> role) {
		super(role);
	}

}
