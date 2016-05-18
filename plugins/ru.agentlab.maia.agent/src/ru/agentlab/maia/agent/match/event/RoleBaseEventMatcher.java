package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.agent.IEventMatcher;
import ru.agentlab.maia.agent.event.AbstractRoleBaseEvent;

public class RoleBaseEventMatcher implements IEventMatcher<Class<?>> {

	Class<? extends AbstractRoleBaseEvent> eventType;

	Class<?> clazz;

	public RoleBaseEventMatcher(Class<? extends AbstractRoleBaseEvent> eventType, Class<?> template) {
		this.eventType = eventType;
		this.clazz = template;
	}

	@Override
	public boolean match(Class<?> payload) {
		return payload == clazz;
	}

}
