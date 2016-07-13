package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;

public class AddedExternalEvent extends Event<Object> {

	public AddedExternalEvent(Object event) {
		super(event);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_EXTERNAL_EVENT;
	}

}
