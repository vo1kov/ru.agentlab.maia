package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class ExternalAddedEvent extends Event<Object> {

	public ExternalAddedEvent(Object event) {
		super(event);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_EXTERNAL_EVENT;
	}

}
