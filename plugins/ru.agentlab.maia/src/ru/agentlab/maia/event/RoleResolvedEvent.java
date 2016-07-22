package ru.agentlab.maia.event;

public class RoleResolvedEvent extends Event<Object> {

	public RoleResolvedEvent(Object role) {
		super(role);
	}

}
