package ru.agentlab.maia.event;

import ru.agentlab.maia.IEvent;

public abstract class Event<T> implements IEvent<T> {

	protected final T payload;

	public Event(T payload) {
		this.payload = payload;
	}

	@Override
	public T getPayload() {
		return payload;
	}

}
