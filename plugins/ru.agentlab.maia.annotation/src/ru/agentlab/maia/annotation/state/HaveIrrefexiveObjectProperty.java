package ru.agentlab.maia.annotation.state;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import de.derivo.sparqldlapi.types.QueryAtomType;
import ru.agentlab.maia.annotation.SparqlDL;
import ru.agentlab.maia.annotation.StateMatcher;

/**
 * @author Dmitriy Shishkin
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@StateMatcher
@SparqlDL(QueryAtomType.IRREFLEXIVE)
public @interface HaveIrrefexiveObjectProperty {

	String value();

}
