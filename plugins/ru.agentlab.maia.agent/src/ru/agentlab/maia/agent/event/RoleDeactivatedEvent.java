package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleDeactivatedEvent extends Event<IRole> {

	public RoleDeactivatedEvent(IRole role) {
		super(role);
	}

}
