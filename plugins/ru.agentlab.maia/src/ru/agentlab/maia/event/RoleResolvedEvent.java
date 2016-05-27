package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class RoleResolvedEvent extends Event<Object> {

	public RoleResolvedEvent(Object role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_RESOLVED;
	}

}
