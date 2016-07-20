package ru.agentlab.maia.role.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.event.RoleRemovedEvent;
import ru.agentlab.maia.role.annotation.converter.OnRoleXXXConverter;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnRoleXXXConverter.class, eventType = RoleRemovedEvent.class)
public @interface OnRoleRemoved {

	Class<? extends Object> value();

}
