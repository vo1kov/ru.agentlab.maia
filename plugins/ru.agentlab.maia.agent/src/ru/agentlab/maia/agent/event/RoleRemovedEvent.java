package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleRemovedEvent extends Event<IRole> {

	public RoleRemovedEvent(IRole role) {
		super(role);
	}

}
