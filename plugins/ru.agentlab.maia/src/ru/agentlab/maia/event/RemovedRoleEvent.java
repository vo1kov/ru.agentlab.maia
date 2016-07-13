package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class RemovedRoleEvent extends Event<Object> {

	public RemovedRoleEvent(Object role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_ROLE;
	}

}
