package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IMessage;

public class MessageAddedEvent extends Event<IMessage> {

	public MessageAddedEvent(IMessage message) {
		super(message);
	}

	@Override
	public EventType getType() {
		return EventType.ADDED_MESSAGE;
	}

}
