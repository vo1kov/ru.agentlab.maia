package ru.agentlab.maia.agent.match;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.anything;
import static org.hamcrest.Matchers.equalTo;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

public class Matchers {

	public static Matcher<OWLClassExpression> isClass(Matcher<? super OWLClass> matcher) {
		return new OWLClassExpressionIsClass(matcher);
	}

	public static Matcher<OWLClassAssertionAxiom> hasClassExpression(Matcher<? super OWLClassExpression> matcher) {
		return new OWLClassAssertionAxiomHasClassExpression(matcher);
	}

	public static Matcher<OWLClassAssertionAxiom> hasIndividual(Matcher<? super OWLIndividual> matcher) {
		return new OWLClassAssertionAxiomHasIndividual(matcher);
	}

	public static Matcher<OWLIndividual> isNamed(Matcher<? super OWLNamedIndividual> matcher) {
		return new OWLIndividualIsNamed(matcher);
	}

	public static Matcher<OWLIndividual> isNamed() {
		return new OWLIndividualIsNamed(anything());
	}

	public static Matcher<OWLPropertyAssertionAxiom<?, ?>> hasSubject(Matcher<? super OWLIndividual> matcher) {
		return new OWLPropertyAssertionAxiomHasSubject(matcher);
	}

	public static Matcher<OWLPropertyAssertionAxiom<?, ?>> hasObject(Matcher<? super OWLIndividual> matcher) {
		return new OWLPropertyAssertionAxiomHasSubject(matcher);
	}

	public static Matcher<OWLPropertyExpression> isObjectProperty(Matcher<? super OWLObjectProperty> matcher) {
		return new OWLPropertyExpressionIsObjectPropertyExpression(matcher);
	}

	public static Matcher<OWLPropertyExpression> isDataProperty(Matcher<? super OWLDataProperty> matcher) {
		return new OWLPropertyExpressionIsDataPropertyExpression(matcher);
	}

	public static Matcher<OWLPropertyAssertionAxiom<?, ?>> hasProperty(Matcher<? super OWLPropertyExpression> matcher) {
		return new OWLPropertyAssertionAxiomHasProperty(matcher);
	}

	public static Matcher<OWLNamedObject> hasIRI(Matcher<? super IRI> matcher) {
		return new OWLNamedObjectHasIRI(matcher);
	}

	public static Matcher<OWLNamedObject> hasIRI(IRI iri) {
		return hasIRI(equalTo(iri));
	}

	public static Matcher<OWLNamedObject> hasIRI(String iri) {
		return hasIRI(equalTo(IRI.create(iri)));
	}

	public static void main(String[] args) {
		// @formatter:off
		allOf(
			hasClassExpression(isClass(hasIRI(""))), 
			hasIndividual(isNamed(hasIRI("")))
		);
		
		allOf(
			hasSubject(isNamed(hasIRI(""))), 
			hasProperty(isDataProperty(hasIRI(""))),
			hasObject(isNamed(hasIRI("")))
		);
		
		allOf(
			hasSubject(isNamed(hasIRI(""))), 
			hasProperty(isObjectProperty(hasIRI(""))),
			hasObject(isNamed(hasIRI("")))
		);
		// @formatter:on
	}

}
