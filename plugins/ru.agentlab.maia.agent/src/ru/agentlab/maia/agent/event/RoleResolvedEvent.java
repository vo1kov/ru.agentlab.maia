package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public class RoleResolvedEvent extends Event<Object> {

	public RoleResolvedEvent(Object role) {
		super(role);
	}

}
