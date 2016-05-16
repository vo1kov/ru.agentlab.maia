package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.agent.Event;

public abstract class MessageQueueEvent extends Event<IMessage> {

	public MessageQueueEvent(IMessage message) {
		super(message);
	}

}