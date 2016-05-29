package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.IMatcher;

public class OWLLiteralPlainMatcher extends OWLLiteralMatcher {

	IMatcher<? super String> literalMatcher;

	IMatcher<? super String> languageMatcher;

	final static IMatcher<? super OWLDatatype> datatypeMatcher = new OWLNamedObjectMatcher(
			OWL2Datatype.RDF_PLAIN_LITERAL.getIRI());

	public OWLLiteralPlainMatcher(IMatcher<? super String> literalMatcher, IMatcher<? super String> languageMatcher) {
		this.literalMatcher = literalMatcher;
		this.languageMatcher = languageMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literalMatcher.match(literal.getLiteral(), map) && languageMatcher.match(literal.getLang(), map)
				&& datatypeMatcher.match(literal.getDatatype(), map);
	}

	@Override
	public String toString() {
		return "OWLLiteralPlainMatcher (" + literalMatcher.toString() + "@" + languageMatcher.toString() + "^^"
				+ datatypeMatcher.toString() + ")";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (obj == this) {
			return true;
		}
		if (obj instanceof OWLLiteralPlainMatcher) {
			OWLLiteralPlainMatcher other = (OWLLiteralPlainMatcher) obj;
			return literalMatcher.equals(other.literalMatcher) && languageMatcher.equals(other.languageMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(literalMatcher, languageMatcher, datatypeMatcher);
	}

}
