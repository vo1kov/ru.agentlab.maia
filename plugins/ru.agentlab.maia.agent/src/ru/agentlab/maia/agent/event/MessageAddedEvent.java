package ru.agentlab.maia.agent.event;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.agent.EventType;

public class MessageAddedEvent extends MessageQueueEvent {

	public MessageAddedEvent(IMessage message) {
		super(message);
	}

	@Override
	public EventType getType() {
		return EventType.PLAN_ADDED;
	}

}
