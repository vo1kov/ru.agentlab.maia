package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class RoleUnresolvedEvent extends Event<Class<?>> {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.ROLE_UNRESOLVED;
	}

}
