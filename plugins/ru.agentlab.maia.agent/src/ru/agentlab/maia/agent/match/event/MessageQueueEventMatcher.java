package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.agent.IEventMatcher;
import ru.agentlab.maia.agent.event.MessageQueueEvent;

public class MessageQueueEventMatcher implements IEventMatcher<Class<?>> {

	Class<? extends MessageQueueEvent> eventType;

	Class<?> clazz;

	public MessageQueueEventMatcher(Class<? extends MessageQueueEvent> eventType, Class<?> template) {
		this.eventType = eventType;
		this.clazz = template;
	}

	@Override
	public boolean match(Class<?> payload) {
		return payload == clazz;
	}

}
