package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;

public class MessageAddedEvent extends AbstractMessageQueueEvent {

	public MessageAddedEvent(IMessage message) {
		super(message);
	}

}
