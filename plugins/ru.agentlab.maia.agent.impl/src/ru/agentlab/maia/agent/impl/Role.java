package ru.agentlab.maia.agent.impl;

import java.util.Collection;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.container.IContainer;

public class Role implements IRole {

	Object roleObject;

	IContainer extra;

	Collection<IPlan> plans;

}
