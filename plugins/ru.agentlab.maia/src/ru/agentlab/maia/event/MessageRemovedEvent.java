package ru.agentlab.maia.event;

import ru.agentlab.maia.IMessage;

public class MessageRemovedEvent extends Event<IMessage> {

	public MessageRemovedEvent(IMessage message) {
		super(message);
	}

}
