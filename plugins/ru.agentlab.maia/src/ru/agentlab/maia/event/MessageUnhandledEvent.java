package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IMessage;

public class MessageUnhandledEvent extends Event<IMessage> {

	public MessageUnhandledEvent(IMessage message) {
		super(message);
	}

	@Override
	public EventType getType() {
		return EventType.UNHANDLED_MESSAGE;
	}

}
