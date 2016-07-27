package ru.agentlab.maia.belief.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import ru.agentlab.maia.belief.annotation.converter.WhenHaveBeliefsConverter;
import ru.agentlab.maia.converter.PlanStateFilter;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Repeatable(WhenHaveBeliefs.class)
@PlanStateFilter(converter=WhenHaveBeliefsConverter.class)
public @interface WhenHaveBelief {

	AxiomType type();

	String[] value();

}
