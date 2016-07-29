package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public class RoleUnresolvedEvent extends Event<Class<?>> {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

}
