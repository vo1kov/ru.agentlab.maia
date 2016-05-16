package ru.agentlab.maia.agent;

public abstract class Event<T> implements IEvent<T> {

	protected T payload;

	public Event(T payload) {
		this.payload = payload;
	}

	@Override
	public T getPayload() {
		return payload;
	}

}
