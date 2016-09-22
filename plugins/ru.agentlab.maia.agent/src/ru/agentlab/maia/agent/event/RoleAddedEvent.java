package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleAddedEvent extends Event<IRole> {

	public RoleAddedEvent(IRole role) {
		super(role);
	}

}
