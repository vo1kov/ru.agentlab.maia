package ru.agentlab.maia.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.EventType;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(EventType.BELIEF_OBJECT_PROPERTY_ADDED)
public @interface BeliefObjectPropertyAdded {

	String value();

}
