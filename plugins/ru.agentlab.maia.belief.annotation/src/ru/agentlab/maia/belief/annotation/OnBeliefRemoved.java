package ru.agentlab.maia.belief.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.belief.annotation.converter.OnBeliefXXXConverter;
import ru.agentlab.maia.belief.event.BeliefRemovedEvent;
import ru.agentlab.maia.converter.PlanEventFilterConverter;
import ru.agentlab.maia.converter.PlanEventType;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventType(BeliefRemovedEvent.class)
@PlanEventFilterConverter(OnBeliefXXXConverter.class)
public @interface OnBeliefRemoved {

	AxiomType type();

	String[] value();

}
