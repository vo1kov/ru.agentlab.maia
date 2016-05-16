package ru.agentlab.maia.agent.event;

public class RoleUnresolvedEvent extends AbstractRoleBaseEvent {

	public RoleUnresolvedEvent(Class<?> role) {
		super(role);
	}

}
