package ru.agentlab.maia.agent.annotation.trigger;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.annotation.converter.OWLClassAssertionAxiomTemplateConverter;
import ru.agentlab.maia.agent.converter.PlanEventFilterConverter;
import ru.agentlab.maia.agent.converter.PlanEventType;
import ru.agentlab.maia.agent.event.AddedBeliefClassAssertionAxiomEvent;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@PlanEventType(AddedBeliefClassAssertionAxiomEvent.class)
@PlanEventFilterConverter(OWLClassAssertionAxiomTemplateConverter.class)
public @interface AddedBeliefClassAssertionAxiom {

	String[] value() default { "?$1", "?$2" };

}
