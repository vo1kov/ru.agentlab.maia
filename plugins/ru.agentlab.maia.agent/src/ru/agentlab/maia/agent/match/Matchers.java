package ru.agentlab.maia.agent.match;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.anything;
import static org.hamcrest.Matchers.equalTo;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;

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

import ru.agentlab.maia.IMessage;

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

	public static Matcher<OWLPropertyAssertionObject> isLiteral(Matcher<? super OWLLiteral> matcher) {
		return new OWLPropertyAssertionObjectIsLiteral(matcher);
	}

	public static Matcher<OWLPropertyAssertionObject> isIndividual(Matcher<? super OWLIndividual> matcher) {
		return new OWLPropertyAssertionObjectIsIndividual(matcher);
	}

	public static Matcher<OWLLiteral> isBoolean(Matcher<? super Boolean> matcher) {
		return new OWLLiteralIsBoolean(matcher);
	}

	public static Matcher<OWLLiteral> isFloat(Matcher<? super Float> matcher) {
		return new OWLLiteralIsFloat(matcher);
	}

	public static Matcher<OWLLiteral> isDouble(Matcher<? super Double> matcher) {
		return new OWLLiteralIsDouble(matcher);
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

	public static Matcher<Object> var(String name, Map<String, Object> values) {
		return new Variable(name, values);
	}

	public static Matcher<IMessage> hasContent(Matcher<? super String> matcher) {
		return new AclMessageHasContent(matcher);
	}

	public static Matcher<IMessage> hasConversationId(Matcher<? super String> matcher) {
		return new AclMessageHasConversationId(matcher);
	}

	public static Matcher<IMessage> hasEncoding(Matcher<? super String> matcher) {
		return new AclMessageHasEncoding(matcher);
	}

	public static Matcher<IMessage> hasInReplyTo(Matcher<? super String> matcher) {
		return new AclMessageHasInReplyTo(matcher);
	}

	public static Matcher<IMessage> hasLanguage(Matcher<? super String> matcher) {
		return new AclMessageHasLanguage(matcher);
	}

	public static Matcher<IMessage> hasOntology(Matcher<? super String> matcher) {
		return new AclMessageHasOntology(matcher);
	}

	public static Matcher<IMessage> hasPerformative(Matcher<? super String> matcher) {
		return new AclMessageHasPerformative(matcher);
	}

	public static Matcher<IMessage> hasPostTimeStamp(Matcher<? super LocalDateTime> matcher) {
		return new AclMessageHasPostTimeStamp(matcher);
	}

	public static Matcher<IMessage> hasProtocol(Matcher<? super String> matcher) {
		return new AclMessageHasProtocol(matcher);
	}

	public static Matcher<IMessage> hasReceivers(Matcher<? super Iterable<UUID>> matcher) {
		return new AclMessageHasReceivers(matcher);
	}

	public static Matcher<IMessage> hasReplyBy(Matcher<? super LocalDateTime> matcher) {
		return new AclMessageHasReplyBy(matcher);
	}

	public static Matcher<IMessage> hasReplyTo(Matcher<? super Iterable<UUID>> matcher) {
		return new AclMessageHasReplyTo(matcher);
	}

	public static Matcher<IMessage> hasReplyWith(Matcher<? super String> matcher) {
		return new AclMessageHasReplyWith(matcher);
	}

	public static Matcher<IMessage> hasSender(Matcher<? super UUID> matcher) {
		return new AclMessageHasSender(matcher);
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
			hasObject(isIndividual(isNamed(hasIRI(""))))
		);
		
		allOf(
			hasSubject(isNamed(hasIRI(""))), 
			hasProperty(isObjectProperty(hasIRI(""))),
			hasObject(isLiteral(isBoolean(anything())))
		);
		// @formatter:on
	}

}
