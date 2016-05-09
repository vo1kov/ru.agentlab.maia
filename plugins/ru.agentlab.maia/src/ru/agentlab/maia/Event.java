package ru.agentlab.maia;

public class Event implements IEvent {

	private Object source;

	private EventType type;

	private Object payload;

	public Event(Object source, EventType type, Object payload) {
		this.source = source;
		this.type = type;
		this.payload = payload;
	}

	@Override
	public EventType getType() {
		return type;
	}

	@Override
	public Object getPayload() {
		return payload;
	}

	@Override
	public Object getSource() {
		return source;
	}

}
