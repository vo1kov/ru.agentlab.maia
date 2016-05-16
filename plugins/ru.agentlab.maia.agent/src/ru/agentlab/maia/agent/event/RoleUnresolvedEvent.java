package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.EventType;

public class RoleUnresolvedEvent extends RoleBaseEvent {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_UNRESOLVED;
	}

}
