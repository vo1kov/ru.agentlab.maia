package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleUnresolvedEvent extends Event<IRole> {

	public RoleUnresolvedEvent(IRole role) {
		super(role);
	}

}
