package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;

public class RoleAddedEvent extends Event<Object> {

	public RoleAddedEvent(Object role) {
		super(role);
	}

}
