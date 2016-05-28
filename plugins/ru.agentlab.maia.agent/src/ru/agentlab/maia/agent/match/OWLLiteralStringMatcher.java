package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

public class OWLLiteralStringMatcher extends OWLLiteralMatcher {

	private final IMatcher<? super String> integerMatcher;

	final static IMatcher<? super OWLDatatype> datatypeMatcher = new OWLNamedObjectMatcher(
			OWL2Datatype.XSD_STRING.getIRI());

	public OWLLiteralStringMatcher(IMatcher<? super String> booleanMatcher) {
		this.integerMatcher = booleanMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return integerMatcher.match(literal.getLiteral(), map) && datatypeMatcher.match(literal.getDatatype(), map);
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
		if (obj instanceof OWLLiteralStringMatcher) {
			OWLLiteralStringMatcher other = (OWLLiteralStringMatcher) obj;
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
