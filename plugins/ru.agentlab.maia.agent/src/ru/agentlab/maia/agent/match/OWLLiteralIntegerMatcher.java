package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

public class OWLLiteralIntegerMatcher extends OWLLiteralMatcher {

	private final IMatcher<? super Integer> integerMatcher;

	final static IMatcher<? super OWLDatatype> datatypeMatcher = new OWLNamedObjectMatcher(
			OWL2Datatype.XSD_INT.getIRI());

	public OWLLiteralIntegerMatcher(IMatcher<? super Integer> booleanMatcher) {
		this.integerMatcher = booleanMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literal.isInteger() && integerMatcher.match(literal.parseInteger(), map);
	}

	@Override
	public Class<?> getType() {
		return OWLLiteral.class;
	}

	@Override
	public String toString() {
		return "OWLLiteralIntegerMatcher (" + integerMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralIntegerMatcher) {
			OWLLiteralIntegerMatcher other = (OWLLiteralIntegerMatcher) obj;
			return integerMatcher.equals(other.integerMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(integerMatcher);
	}

}
