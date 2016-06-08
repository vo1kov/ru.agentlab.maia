package ru.agentlab.maia.annotation.state;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import de.derivo.sparqldlapi.types.QueryAtomType;
import ru.agentlab.maia.annotation.SparqlDL;

/**
 * @author Dmitriy Shishkin
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@SparqlDL(QueryAtomType.FUNCTIONAL)
public @interface HaveFunctionalDataProperty {

	String value();

}
