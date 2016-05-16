package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;

public class MessageUnhandledEvent extends AbstractMessageQueueEvent {

	public MessageUnhandledEvent(IMessage message) {
		super(message);
	}

}
