package ru.agentlab.maia.event;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IMessage;

public class RemovedMessageEvent extends Event<IMessage> {

	public RemovedMessageEvent(IMessage message) {
		super(message);
	}

	@Override
	public EventType getType() {
		return EventType.REMOVED_MESSAGE;
	}

}
