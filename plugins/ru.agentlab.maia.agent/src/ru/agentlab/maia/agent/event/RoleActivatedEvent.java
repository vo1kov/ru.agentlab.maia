package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IRole;

public class RoleActivatedEvent extends Event<IRole> {

	public RoleActivatedEvent(IRole role) {
		super(role);
	}

}
