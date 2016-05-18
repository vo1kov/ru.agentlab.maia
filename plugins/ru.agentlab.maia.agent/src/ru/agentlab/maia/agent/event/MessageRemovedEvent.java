package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;

public class MessageRemovedEvent extends AbstractMessageQueueEvent {

	public MessageRemovedEvent(IMessage message) {
		super(message);
	}

}
