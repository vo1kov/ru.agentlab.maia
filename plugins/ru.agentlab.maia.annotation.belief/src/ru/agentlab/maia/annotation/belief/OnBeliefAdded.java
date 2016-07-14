package ru.agentlab.maia.annotation.belief;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.EventMatcher;
import ru.agentlab.maia.annotation.belief.converter.OnBeliefXXXConverter;
import ru.agentlab.maia.event.BeliefAddedEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@EventMatcher(converter = OnBeliefXXXConverter.class, eventType = BeliefAddedEvent.class)
public @interface OnBeliefAdded {

	AxiomType type();

	String[] value();

}
