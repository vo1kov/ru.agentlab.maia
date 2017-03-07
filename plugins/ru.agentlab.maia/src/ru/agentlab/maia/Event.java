package ru.agentlab.maia;

import java.util.Objects;

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

	@Override
	@SuppressWarnings("rawtypes")
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		return Objects.equals(getClass(), obj.getClass()) && Objects.equals(payload, ((Event) obj).payload);
	}

	@Override
	public int hashCode() {
		return Objects.hash(getClass(), payload);
	}

}
