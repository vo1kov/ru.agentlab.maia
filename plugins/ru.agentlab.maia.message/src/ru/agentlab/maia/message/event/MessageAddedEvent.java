package ru.agentlab.maia.message.event;

import ru.agentlab.maia.Event;
import ru.agentlab.maia.message.IMessage;

public class MessageAddedEvent extends Event<IMessage> {

	public MessageAddedEvent(IMessage message) {
		super(message);
	}

}
