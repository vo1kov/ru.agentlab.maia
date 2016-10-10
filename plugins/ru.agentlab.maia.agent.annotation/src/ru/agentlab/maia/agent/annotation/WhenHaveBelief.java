package ru.agentlab.maia.agent.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.agent.annotation.converter.WhenHaveBeliefsConverter;
import ru.agentlab.maia.converter.PlanStateFilterConverter;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Repeatable(WhenHaveBeliefs.class)
@PlanStateFilterConverter(WhenHaveBeliefsConverter.class)
public @interface WhenHaveBelief {

	AxiomType type();

	String[] value();

}
