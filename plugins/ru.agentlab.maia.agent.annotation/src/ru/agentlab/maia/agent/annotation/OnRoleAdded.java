package ru.agentlab.maia.agent.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.annotation.converter.OnRoleXXXConverter;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.converter.PlanEventFilter;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventFilter(converter = OnRoleXXXConverter.class, eventType = RoleAddedEvent.class)
public @interface OnRoleAdded {

	Class<?> value();

}
