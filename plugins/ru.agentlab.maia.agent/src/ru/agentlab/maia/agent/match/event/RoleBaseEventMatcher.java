package ru.agentlab.maia.agent.match.event;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.common.JavaClassMatcher;
import ru.agentlab.maia.event.AbstractRoleBaseEvent;

public class RoleBaseEventMatcher implements IMatcher<Class<?>> {

	Class<? extends AbstractRoleBaseEvent> eventType;

	JavaClassMatcher template;

	public RoleBaseEventMatcher(Class<? extends AbstractRoleBaseEvent> eventType, JavaClassMatcher template) {
		this.eventType = eventType;
		this.template = template;
	}

	@Override
	public IMatch match(Class<?> payload) {
		return template.match(payload);
	}

}
