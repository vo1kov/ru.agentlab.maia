package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.EventType;

public class RoleResolvedEvent extends RoleBaseEvent {

	public RoleResolvedEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_RESOLVED;
	}

}
