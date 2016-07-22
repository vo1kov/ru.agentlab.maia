package ru.agentlab.maia.agent.role.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.role.annotation.converter.OnRoleXXXConverter;
import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.event.RoleAddedEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnRoleXXXConverter.class, eventType = RoleAddedEvent.class)
public @interface OnRoleAdded {

	Class<?> value();

}
