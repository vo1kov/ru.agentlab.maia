package ru.agentlab.maia.message.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.message.IMessage;

public class MessageUnhandledEvent extends Event<IMessage> {

	public MessageUnhandledEvent(IMessage message) {
		super(message);
	}

}
