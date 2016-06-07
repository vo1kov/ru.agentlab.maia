package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IMessage;

public class UnhandledMessageEvent extends Event<IMessage> {

	public UnhandledMessageEvent(IMessage message) {
		super(message);
	}

	@Override
	public EventType getType() {
		return EventType.UNHANDLED_MESSAGE;
	}

}
