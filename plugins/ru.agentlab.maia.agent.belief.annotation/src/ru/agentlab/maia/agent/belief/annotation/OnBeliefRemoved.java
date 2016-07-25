package ru.agentlab.maia.agent.belief.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.belief.annotation.converter.OnBeliefXXXConverter;
import ru.agentlab.maia.agent.belief.event.BeliefRemovedEvent;
import ru.agentlab.maia.annotation.EventMatcher;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnBeliefXXXConverter.class, eventType = BeliefRemovedEvent.class)
public @interface OnBeliefRemoved {

	AxiomType type();

	String[] value();

}
