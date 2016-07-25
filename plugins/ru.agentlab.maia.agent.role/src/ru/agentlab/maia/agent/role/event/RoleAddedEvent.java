package ru.agentlab.maia.agent.role.event;

import ru.agentlab.maia.Event;

public class RoleAddedEvent extends Event<Object> {

	public RoleAddedEvent(Object role) {
		super(role);
	}

}
