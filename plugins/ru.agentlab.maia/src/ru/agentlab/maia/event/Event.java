package ru.agentlab.maia.event;

import java.util.Objects;

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

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof IEvent<?>) {
			IEvent<?> other = (IEvent<?>) obj;
			return (payload == other.getPayload()) && (this.getType() == other.getType());
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(getType(), payload);
	}

}
