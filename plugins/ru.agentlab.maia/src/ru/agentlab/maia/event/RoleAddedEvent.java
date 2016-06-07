package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class RoleAddedEvent extends Event<Object> {

	public RoleAddedEvent(Object role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_ROLE;
	}

}
