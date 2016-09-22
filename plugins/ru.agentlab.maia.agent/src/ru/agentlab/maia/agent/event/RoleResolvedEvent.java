package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleResolvedEvent extends Event<IRole> {

	public RoleResolvedEvent(IRole role) {
		super(role);
	}

}
