package ru.agentlab.maia.agent;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.Set;

public class EventQueue extends LinkedList<IEvent<?>> implements IEventQueue {

	private Set<EventType> filters = new HashSet<EventType>();

	private static final long serialVersionUID = 1L;

	@Override
	public void allow(EventType type) {
		filters.add(type);
	}

	@Override
	public void disallow(EventType type) {
		filters.remove(type);
	}

	@Override
	public boolean offer(IEvent<?> e) {
		if (filters.contains(e.getType())) {
			return super.offer(e);
		} else {
			return false;
		}
	}

}
