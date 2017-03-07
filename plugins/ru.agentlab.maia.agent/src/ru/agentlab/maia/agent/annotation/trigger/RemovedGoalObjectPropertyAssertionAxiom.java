package ru.agentlab.maia.agent.annotation.trigger;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.annotation.converter.OWLObjectPropertyAssertionAxiomTemplateConverter;
import ru.agentlab.maia.agent.converter.PlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.PlanEventType;
import ru.agentlab.maia.agent.event.RemovedGoalObjectPropertyAssertionAxiomEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventType(RemovedGoalObjectPropertyAssertionAxiomEvent.class)
@PlanEventFilterConverter(OWLObjectPropertyAssertionAxiomTemplateConverter.class)
public @interface RemovedGoalObjectPropertyAssertionAxiom {

	String[] value() default { "?$1", "?$2", "?$3" };

}
