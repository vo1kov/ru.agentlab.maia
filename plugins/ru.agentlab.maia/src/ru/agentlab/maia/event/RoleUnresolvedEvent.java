package ru.agentlab.maia.event;

public class RoleUnresolvedEvent extends Event<Class<?>> {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

}
