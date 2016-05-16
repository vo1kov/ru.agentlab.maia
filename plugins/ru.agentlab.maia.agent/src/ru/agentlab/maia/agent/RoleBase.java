package ru.agentlab.maia.agent;

import java.util.HashMap;
import java.util.Map;
import java.util.Queue;

import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.agent.event.RoleResolvedEvent;
import ru.agentlab.maia.agent.event.RoleUnresolvedEvent;
import ru.agentlab.maia.exception.ContainerException;
import ru.agentlab.maia.exception.InjectorException;
import ru.agentlab.maia.exception.ResolveException;

public class RoleBase implements IRoleBase {

	IInjector injector;

	private Map<Class<?>, Object> map = new HashMap<>();

	private final Queue<IEvent<?>> eventQueue;

	public RoleBase(Queue<IEvent<?>> eventQueue, IInjector injector) {
		this.eventQueue = eventQueue;
		this.injector = injector;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRoleBase#addRole(java.lang.Class)
	 */
	@Override
	public void add(Class<?> role) {
		map.put(role, null);
		eventQueue.offer(new RoleAddedEvent(role));
	}

	@Override
	public void add(Class<?>... roles) {
		for (Class<?> role : roles) {
			add(role);
		}
	}

	@Override
	public void resolve(Class<?> roleClass) throws ResolveException {
		try {
			injector.make(roleClass);
			eventQueue.offer(new RoleResolvedEvent(roleClass));
		} catch (InjectorException | ContainerException e) {
			eventQueue.offer(new RoleUnresolvedEvent(roleClass));
			throw new ResolveException();
		}
	}

	@Override
	public void resolve(Class<?>... roleClasses) throws ResolveException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see ru.agentlab.maia.agent.IRoleBase#resolve()
	 */
	@Override
	public void resolveAll() throws ResolveException {
		for (Map.Entry<Class<?>, Object> entry : map.entrySet()) {
			if (entry.getValue() == null) {
				try {
					Object role = injector.make(entry.getKey());
					entry.setValue(role);
				} catch (InjectorException | ContainerException e) {
					// e.printStackTrace();
				}
			}
		}
	}

	@Override
	public boolean contains(Class<?> clazz) {
		return map.containsKey(clazz);
	}

	@Override
	public void remove(Class<?> roleClass) {
		// TODO Auto-generated method stub

	}

	@Override
	public void remove(Class<?>... roleClasses) {
		// TODO Auto-generated method stub

	}

}
