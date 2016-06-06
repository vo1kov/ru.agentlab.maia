package ru.agentlab.maia.annotation.event;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.annotation.EventMatcher;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(EventType.ROLE_UNRESOLVED)
public @interface UnresolvedRole {

	Class<?> value();

}
