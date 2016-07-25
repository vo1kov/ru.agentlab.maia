package ru.agentlab.maia;

public abstract class Event<T> implements IEvent<T> {

	protected final T payload;

	public Event(T payload) {
		this.payload = payload;
	}

	@Override
	public T getPayload() {
		return payload;
	}

	@Override
	public String toString() {
		return getClass().getSimpleName() + " " + payload.toString();
	}

}
