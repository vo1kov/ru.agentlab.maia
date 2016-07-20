package ru.agentlab.maia.annotation.role;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.role.converter.OnRoleXXXConverter;
import ru.agentlab.maia.event.RoleRemovedEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnRoleXXXConverter.class, eventType = RoleRemovedEvent.class)
public @interface OnRoleRemoved {

	Class<? extends Object> value();

}
