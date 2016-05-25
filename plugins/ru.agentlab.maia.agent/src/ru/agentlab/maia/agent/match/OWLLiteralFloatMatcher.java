package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

public class OWLLiteralFloatMatcher extends OWLLiteralMatcher {

	private final IMatcher<? super Float> floatMatcher;

	final static IMatcher<? super OWLDatatype> datatypeMatcher = new OWLNamedObjectMatcher(
			OWL2Datatype.XSD_FLOAT.getIRI());

	public OWLLiteralFloatMatcher(IMatcher<? super Float> booleanMatcher) {
		this.floatMatcher = booleanMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literal.isFloat() && floatMatcher.match(literal.parseFloat(), map);
	}

	@Override
	public Class<?> getType() {
		return OWLLiteral.class;
	}

	@Override
	public String toString() {
		return "OWLLiteralFloatMatcher (" + floatMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralFloatMatcher) {
			OWLLiteralFloatMatcher other = (OWLLiteralFloatMatcher) obj;
			return floatMatcher.equals(other.floatMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(floatMatcher);
	}

}
