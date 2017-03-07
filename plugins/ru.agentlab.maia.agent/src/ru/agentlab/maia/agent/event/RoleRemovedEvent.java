package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IRole;

public class RoleRemovedEvent extends Event<IRole> {

	public RoleRemovedEvent(IRole payload) {
		super(payload);
		// TODO Auto-generated constructor stub
	}

}
