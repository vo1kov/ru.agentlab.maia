package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class UnresolvedRoleEvent extends Event<Class<?>> {

	public UnresolvedRoleEvent(Class<?> role) {
		super(role);
	}

	@Override
	public EventType getType() {
		return EventType.UNRESOLVED_ROLE;
	}

}
