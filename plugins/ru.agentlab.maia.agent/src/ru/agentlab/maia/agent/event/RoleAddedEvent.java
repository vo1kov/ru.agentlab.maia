package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.EventType;

public class RoleAddedEvent extends RoleBaseEvent {

	public RoleAddedEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_ADDED;
	}

}
