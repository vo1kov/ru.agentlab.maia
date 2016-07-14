package ru.agentlab.maia.event;

public class RoleRemovedEvent extends Event<Object> {

	public RoleRemovedEvent(Object role) {
		super(role);
	}

}
