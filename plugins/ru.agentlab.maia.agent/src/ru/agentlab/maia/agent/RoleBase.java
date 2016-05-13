package ru.agentlab.maia.agent;

import java.util.HashMap;
import java.util.Map;

import ru.agentlab.maia.IAgent;
import ru.agentlab.maia.IEventQueue;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

public class RoleBase implements IRoleBase {

	IAgent agent;

	IEventQueue eventQueue;

	private Map<Class<?>, Object> map = new HashMap<>();

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRoleBase#addRole(java.lang.Class)
	 */
	@Override
	public void addRole(Class<?> role) {
		map.put(role, null);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRoleBase#resolve()
	 */
	@Override
	public void resolve() throws ResolveException {
		for (Map.Entry<Class<?>, Object> entry : map.entrySet()) {
			if (entry.getValue() == null) {
				try {
					Object role = agent.getContainer().getInjector().make(entry.getKey());
					entry.setValue(role);
				} catch (InjectorException | ContainerException e) {
					// e.printStackTrace();
				}
			}
		}
	}

}
