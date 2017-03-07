package ru.agentlab.maia.service.message.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IMessage;

public class MessageUnhandledEvent extends Event<IMessage> {

	public MessageUnhandledEvent(IMessage message) {
		super(message);
	}

}
