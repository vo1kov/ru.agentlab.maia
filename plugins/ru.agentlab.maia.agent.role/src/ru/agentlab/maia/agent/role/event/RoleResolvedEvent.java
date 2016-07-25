package ru.agentlab.maia.agent.role.event;

import ru.agentlab.maia.Event;

public class RoleResolvedEvent extends Event<Object> {

	public RoleResolvedEvent(Object role) {
		super(role);
	}

}
