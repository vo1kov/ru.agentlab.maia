package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class RoleRemovedEvent extends Event<Object> {

	public RoleRemovedEvent(Object role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_REMOVED;
	}

}
