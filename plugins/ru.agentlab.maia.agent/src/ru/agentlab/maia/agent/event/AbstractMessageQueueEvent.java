package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.agent.Event;

public abstract class AbstractMessageQueueEvent extends Event<IMessage> {

	public AbstractMessageQueueEvent(IMessage message) {
		super(message);
	}

}