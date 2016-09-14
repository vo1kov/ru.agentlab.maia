package ru.agentlab.maia.message.event;

import ru.agentlab.maia.agent.Event;
import ru.agentlab.maia.agent.IMessage;

public class MessageReceivedEvent extends Event<IMessage> {

	public MessageReceivedEvent(IMessage message) {
		super(message);
	}

}
