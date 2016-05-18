package ru.agentlab.maia.agent.event;

public class RoleRemovedEvent extends AbstractRoleBaseEvent {

	public RoleRemovedEvent(Class<?> role) {
		super(role);
	}

}
