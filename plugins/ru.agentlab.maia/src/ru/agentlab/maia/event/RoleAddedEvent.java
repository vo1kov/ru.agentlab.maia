package ru.agentlab.maia.event;

public class RoleAddedEvent extends Event<Object> {

	public RoleAddedEvent(Object role) {
		super(role);
	}

}
