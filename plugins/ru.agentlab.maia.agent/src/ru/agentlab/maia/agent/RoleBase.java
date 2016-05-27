package ru.agentlab.maia.agent;

import java.util.Collection;
import java.util.HashSet;
import java.util.Queue;
import java.util.Set;
import java.util.stream.Stream;

import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.IRoleBase;
import ru.agentlab.maia.event.RoleAddedEvent;
import ru.agentlab.maia.event.RoleRemovedEvent;

public class RoleBase implements IRoleBase {

	protected final Set<Object> map = new HashSet<>();

	protected final Queue<IEvent<?>> eventQueue;

	public RoleBase(Queue<IEvent<?>> eventQueue) {
		this.eventQueue = eventQueue;
	}

	@Override
	public boolean addRole(Object roleObject) {
		boolean result = map.add(roleObject);
		if (result) {
			eventQueue.offer(new RoleAddedEvent(roleObject));
		}
		return result;
	}

	@Override
	public boolean contains(Object roleObject) {
		return map.contains(roleObject);
	}

	@Override
	public boolean remove(Object roleObject) {
		boolean result = map.remove(roleObject);
		if (result) {
			eventQueue.offer(new RoleRemovedEvent(roleObject));
		}
		return result;
	}

	@Override
	public void clear() {
		Stream<RoleRemovedEvent> events = map.stream().map(role -> new RoleRemovedEvent(role));
		map.clear();
		events.forEach(eventQueue::offer);
	}

	@Override
	public Collection<Object> getRoles() {
		return map;
	}

}
