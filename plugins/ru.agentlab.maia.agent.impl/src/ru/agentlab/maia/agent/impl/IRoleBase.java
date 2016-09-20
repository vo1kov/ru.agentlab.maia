package ru.agentlab.maia.agent.impl;

public interface IRoleBase {

	void addRole(IRole role);

	void activateRole(IRole role);

	void deactivateRole(IRole role);

	void removeRole(IRole role);

}