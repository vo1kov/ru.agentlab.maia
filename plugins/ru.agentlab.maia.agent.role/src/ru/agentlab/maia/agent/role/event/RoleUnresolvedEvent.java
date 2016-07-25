package ru.agentlab.maia.agent.role.event;

import ru.agentlab.maia.Event;

public class RoleUnresolvedEvent extends Event<Class<?>> {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

}
