package ru.agentlab.maia.hamcrest.owlapi;

import static org.hamcrest.CoreMatchers.anything;
import static org.hamcrest.CoreMatchers.equalTo;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;
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

	public static Matcher<OWLPropertyAssertionAxiom<?, ?>> hasObject(
			Matcher<? super OWLPropertyAssertionObject> matcher) {
		return new OWLPropertyAssertionAxiomHasObject(matcher);
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

	public static Matcher<OWLNamedObject> hasIRI(String namespace, String name) {
		return hasIRI(equalTo(IRI.create(namespace, name)));
	}

	public static Matcher<OWLPropertyAssertionObject> isLiteral(Matcher<? super OWLLiteral> matcher) {
		return new OWLPropertyAssertionObjectIsLiteral(matcher);
	}

	public static Matcher<OWLPropertyAssertionObject> isIndividual(Matcher<? super OWLIndividual> matcher) {
		return new OWLPropertyAssertionObjectIsIndividual(matcher);
	}

	public static Matcher<OWLLiteral> isBoolean(Matcher<? super Boolean> matcher) {
		return new OWLLiteralIsBoolean(matcher);
	}

	public static Matcher<OWLLiteral> isBoolean(boolean value) {
		return new OWLLiteralIsBoolean(equalTo(value));
	}

	public static Matcher<OWLLiteral> isFloat(Matcher<? super Float> matcher) {
		return new OWLLiteralIsFloat(matcher);
	}

	public static Matcher<OWLLiteral> isFloat(float value) {
		return new OWLLiteralIsFloat(equalTo(value));
	}

	public static Matcher<OWLLiteral> isDouble(Matcher<? super Double> matcher) {
		return new OWLLiteralIsDouble(matcher);
	}

	public static Matcher<OWLLiteral> isDouble(double value) {
		return new OWLLiteralIsDouble(equalTo(value));
	}

	public static Matcher<OWLLiteral> isInteger(Matcher<? super Integer> matcher) {
		return new OWLLiteralIsInteger(matcher);
	}

	public static Matcher<OWLLiteral> isTyped(Matcher<? super String> valueMatcher,
			Matcher<? super OWLDatatype> datatypeMatcher) {
		return new OWLLiteralIsTyped(valueMatcher, datatypeMatcher);
	}

	public static Matcher<OWLLiteral> isPlain(Matcher<? super String> valueMatcher,
			Matcher<? super String> languageMatcher) {
		return new OWLLiteralIsPlain(valueMatcher, languageMatcher);
	}

	public static Matcher<OWLLiteral> isPlain(Matcher<? super String> valueMatcher) {
		return new OWLLiteralIsPlain(valueMatcher, anything());
	}

}
