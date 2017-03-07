package ru.agentlab.maia.service.message.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.IMessage;

public class MessageReceivedEvent extends Event<IMessage> {

	public MessageReceivedEvent(IMessage message) {
		super(message);
	}

}
