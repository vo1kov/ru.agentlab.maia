package ru.agentlab.maia.agent.role.event;

import ru.agentlab.maia.Event;

public class RoleRemovedEvent extends Event<Object> {

	public RoleRemovedEvent(Object role) {
		super(role);
	}

}
