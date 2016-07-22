package ru.agentlab.maia.belief.match;

import static org.hamcrest.CoreMatchers.anything;
import static org.hamcrest.CoreMatchers.equalTo;
import static ru.agentlab.maia.match.EventMatchers.hamcrest;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLDifferentIndividualsAxiom;
import org.semanticweb.owlapi.model.OWLDisjointClassesAxiom;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;
import org.semanticweb.owlapi.model.OWLPropertyExpression;

import ru.agentlab.maia.IEventMatcher;

public class Matchers {

	public static IEventMatcher<OWLDisjointClassesAxiom> hasDisjointClasses(
			IEventMatcher<? super OWLClassExpression>[] matchers) {
		return new OWLDisjointClassesAxiomHasClasses(matchers);
	}

	public static IEventMatcher<OWLDifferentIndividualsAxiom> hasDifferentIndividuals(
			IEventMatcher<? super OWLIndividual>[] matchers) {
		return new OWLDifferentIndividualsAxiomHasIndividuals(matchers);
	}

	public static IEventMatcher<OWLClassExpression> isNamedClass(IEventMatcher<? super OWLClass> IEventMatcher) {
		return new OWLClassExpressionIsClass(IEventMatcher);
	}

	public static IEventMatcher<OWLClassAssertionAxiom> hasClassExpression(
			IEventMatcher<? super OWLClassExpression> IEventMatcher) {
		return new OWLClassAssertionAxiomHasClassExpression(IEventMatcher);
	}

	public static IEventMatcher<OWLClassAssertionAxiom> hasIndividual(
			IEventMatcher<? super OWLIndividual> IEventMatcher) {
		return new OWLClassAssertionAxiomHasIndividual(IEventMatcher);
	}

	public static IEventMatcher<OWLIndividual> isNamedIndividual(
			IEventMatcher<? super OWLNamedIndividual> IEventMatcher) {
		return new OWLIndividualIsNamed(IEventMatcher);
	}

	public static IEventMatcher<OWLIndividual> isNamed() {
		return new OWLIndividualIsNamed(hamcrest(anything()));
	}

	public static IEventMatcher<OWLPropertyAssertionAxiom<?, ?>> hasSubject(
			IEventMatcher<? super OWLIndividual> IEventMatcher) {
		return new OWLPropertyAssertionAxiomHasSubject(IEventMatcher);
	}

	public static IEventMatcher<OWLPropertyAssertionAxiom<?, ?>> hasObject(
			IEventMatcher<? super OWLPropertyAssertionObject> IEventMatcher) {
		return new OWLPropertyAssertionAxiomHasObject(IEventMatcher);
	}

	public static IEventMatcher<OWLPropertyExpression> isObjectProperty(
			IEventMatcher<? super OWLObjectProperty> IEventMatcher) {
		return new OWLPropertyExpressionIsObjectPropertyExpression(IEventMatcher);
	}

	public static IEventMatcher<OWLPropertyExpression> isDataProperty(
			IEventMatcher<? super OWLDataProperty> IEventMatcher) {
		return new OWLPropertyExpressionIsDataPropertyExpression(IEventMatcher);
	}

	public static IEventMatcher<OWLPropertyAssertionAxiom<?, ?>> hasProperty(
			IEventMatcher<? super OWLPropertyExpression> IEventMatcher) {
		return new OWLPropertyAssertionAxiomHasProperty(IEventMatcher);
	}

	public static IEventMatcher<OWLNamedObject> hasIRI(IEventMatcher<? super IRI> IEventMatcher) {
		return new OWLNamedObjectHasIRI(IEventMatcher);
	}

	public static IEventMatcher<OWLNamedObject> hasIRI(IRI iri) {
		return hasIRI(hamcrest(equalTo(iri)));
	}

	public static IEventMatcher<OWLNamedObject> hasIRI(String iri) {
		return hasIRI(hamcrest(equalTo(IRI.create(iri))));
	}

	public static IEventMatcher<OWLNamedObject> hasIRI(String namespace, String name) {
		return hasIRI(hamcrest(equalTo(IRI.create(namespace, name))));
	}

	public static IEventMatcher<OWLPropertyAssertionObject> isLiteral(IEventMatcher<? super OWLLiteral> IEventMatcher) {
		return new OWLPropertyAssertionObjectIsLiteral(IEventMatcher);
	}

	public static IEventMatcher<OWLPropertyAssertionObject> isIndividual(
			IEventMatcher<? super OWLIndividual> IEventMatcher) {
		return new OWLPropertyAssertionObjectIsIndividual(IEventMatcher);
	}

	public static IEventMatcher<OWLLiteral> isBooleanLiteral(IEventMatcher<? super Boolean> IEventMatcher) {
		return new OWLLiteralIsBoolean(IEventMatcher);
	}

	public static IEventMatcher<OWLLiteral> isBooleanLiteral(boolean value) {
		return new OWLLiteralIsBoolean(hamcrest(equalTo(value)));
	}

	public static IEventMatcher<OWLLiteral> isFloatLiteral(IEventMatcher<? super Float> IEventMatcher) {
		return new OWLLiteralIsFloat(IEventMatcher);
	}

	public static IEventMatcher<OWLLiteral> isFloatLiteral(float value) {
		return new OWLLiteralIsFloat(hamcrest(equalTo(value)));
	}

	public static IEventMatcher<OWLLiteral> isDoubleLiteral(IEventMatcher<? super Double> IEventMatcher) {
		return new OWLLiteralIsDouble(IEventMatcher);
	}

	public static IEventMatcher<OWLLiteral> isDoubleLiteral(double value) {
		return new OWLLiteralIsDouble(hamcrest(equalTo(value)));
	}

	public static IEventMatcher<OWLLiteral> isIntegerLiteral(IEventMatcher<? super Integer> IEventMatcher) {
		return new OWLLiteralIsInteger(IEventMatcher);
	}

	public static IEventMatcher<OWLLiteral> isTypedLiteral(IEventMatcher<? super String> valueMatcher,
			IEventMatcher<? super OWLDatatype> datatypeMatcher) {
		return new OWLLiteralIsTyped(valueMatcher, datatypeMatcher);
	}

	public static IEventMatcher<OWLLiteral> isPlainLiteral(IEventMatcher<? super String> valueMatcher,
			IEventMatcher<? super String> languageMatcher) {
		return new OWLLiteralIsPlain(valueMatcher, languageMatcher);
	}

	public static IEventMatcher<OWLLiteral> isPlain(IEventMatcher<? super String> valueMatcher) {
		return new OWLLiteralIsPlain(valueMatcher, hamcrest(anything()));
	}

}
