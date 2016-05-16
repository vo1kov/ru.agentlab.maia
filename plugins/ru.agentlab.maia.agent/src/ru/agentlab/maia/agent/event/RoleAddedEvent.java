package ru.agentlab.maia.agent.event;

public class RoleAddedEvent extends AbstractRoleBaseEvent {

	public RoleAddedEvent(Class<?> role) {
		super(role);
	}

}
