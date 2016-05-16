package ru.agentlab.maia.agent;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.Set;

import ru.agentlab.maia.IEvent;

public class EventQueue extends LinkedList<IEvent<?>> implements IEventQueue {

	private Set<Class<? extends IEvent<?>>> filters = new HashSet<>();

	private static final long serialVersionUID = 1L;

	@Override
	public void allow(Class<? extends IEvent<?>> type) {
		filters.add(type);
	}

	@Override
	public void disallow(Class<? extends IEvent<?>> type) {
		filters.remove(type);
	}

	@Override
	public boolean offer(IEvent<?> e) {
		if (filters.contains(e.getClass())) {
			return super.offer(e);
		} else {
			return false;
		}
	}

}
