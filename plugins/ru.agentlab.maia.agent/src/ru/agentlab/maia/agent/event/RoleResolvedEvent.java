package ru.agentlab.maia.agent.event;

public class RoleResolvedEvent extends AbstractRoleBaseEvent {

	public RoleResolvedEvent(Class<?> role) {
		super(role);
	}

}
