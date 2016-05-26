package ru.agentlab.maia.agent;

import java.util.Map;

import ru.agentlab.maia.IRole;

public class Role implements IRole {

	private final Class<?> roleClass;

	private final Map<String, Object> parameters;

	public Role(Class<?> roleClass, Map<String, Object> parameters) {
		super();
		this.roleClass = roleClass;
		this.parameters = parameters;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRole#getRoleClass()
	 */
	@Override
	public Class<?> getRoleClass() {
		return roleClass;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRole#getParameters()
	 */
	@Override
	public Map<String, Object> getParameters() {
		return parameters;
	}

}
