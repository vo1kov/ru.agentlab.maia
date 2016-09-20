package ru.agentlab.maia.agent.impl;

import java.util.HashSet;
import java.util.Queue;
import java.util.Set;

public class RoleBase implements IRoleBase {

	protected final Set<Object> inactiveRoles = new HashSet<>();

	protected final Set<Object> activeRoles = new HashSet<>();

	protected final Queue<Object> eventQueue;

	public RoleBase(Queue<Object> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public void addRole(IRole role) {

	}

	@Override
	public void activateRole(IRole role) {

	}

	@Override
	public void deactivateRole(IRole role) {

	}

	@Override
	public void removeRole(IRole role) {

	}

}
