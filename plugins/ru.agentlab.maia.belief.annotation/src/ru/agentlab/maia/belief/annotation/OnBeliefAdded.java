package ru.agentlab.maia.belief.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.annotation.PlanEventFilter;
import ru.agentlab.maia.belief.annotation.converter.OnBeliefXXXConverter;
import ru.agentlab.maia.belief.event.BeliefAddedEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventFilter(converter = OnBeliefXXXConverter.class, eventType = BeliefAddedEvent.class)
public @interface OnBeliefAdded {

	AxiomType type();

	String[] value();

}
