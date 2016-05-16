package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.EventType;

public class RoleRemovedEvent extends RoleBaseEvent {

	public RoleRemovedEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_REMOVED;
	}

}
