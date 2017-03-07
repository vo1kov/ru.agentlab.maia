package ru.agentlab.maia.service.message.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IMessage;

public class MessageRemovedEvent extends Event<IMessage> {

	public MessageRemovedEvent(IMessage message) {
		super(message);
	}

}
