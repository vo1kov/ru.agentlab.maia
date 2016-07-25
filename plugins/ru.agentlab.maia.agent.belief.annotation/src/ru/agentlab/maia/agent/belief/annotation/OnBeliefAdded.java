package ru.agentlab.maia.agent.belief.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.belief.annotation.converter.OnBeliefXXXConverter;
import ru.agentlab.maia.agent.belief.event.BeliefAddedEvent;
import ru.agentlab.maia.annotation.EventMatcher;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnBeliefXXXConverter.class, eventType = BeliefAddedEvent.class)
public @interface OnBeliefAdded {

	AxiomType type();

	String[] value();

}
