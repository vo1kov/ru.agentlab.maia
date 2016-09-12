package ru.agentlab.maia.message.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IMessage;

public class MessageUnhandledEvent extends Event<IMessage> {

	public MessageUnhandledEvent(IMessage message) {
		super(message);
	}

}
