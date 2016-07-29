package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public class RoleRemovedEvent extends Event<Object> {

	public RoleRemovedEvent(Object role) {
		super(role);
	}

}
