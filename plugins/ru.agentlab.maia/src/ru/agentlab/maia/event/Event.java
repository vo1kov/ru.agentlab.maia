package ru.agentlab.maia.event;

import ru.agentlab.maia.IEvent;

public class Event implements IEvent {

	private Object source;

	private EventType type;

	private Object payload;

	public Event(Object source, EventType type, Object payload) {
		this.source = source;
		this.type = type;
		this.payload = payload;
	}

	public EventType getType() {
		return type;
	}

	public Object getPayload() {
		return payload;
	}

	public Object getSource() {
		return source;
	}

}
