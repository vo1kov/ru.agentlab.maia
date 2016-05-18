package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.agent.IEventMatcher;
import ru.agentlab.maia.agent.event.AbstractMessageQueueEvent;

public class MessageQueueEventMatcher implements IEventMatcher<Class<?>> {

	Class<? extends AbstractMessageQueueEvent> eventType;

	Class<?> clazz;

	public MessageQueueEventMatcher(Class<? extends AbstractMessageQueueEvent> eventType, Class<?> template) {
		this.eventType = eventType;
		this.clazz = template;
	}

	@Override
	public boolean match(Class<?> payload) {
		return payload == clazz;
	}

}
