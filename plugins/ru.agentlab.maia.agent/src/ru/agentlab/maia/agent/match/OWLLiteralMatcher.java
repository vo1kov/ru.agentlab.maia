package ru.agentlab.maia.agent.match;

import java.util.Map;
import java.util.Objects;

import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLLiteralMatcher implements IMatcher<OWLLiteral> {

	IMatcher<? super String> literalMatcher;

	IMatcher<? super String> languageMatcher;

	IMatcher<? super OWLDatatype> datatypeMatcher;

	public OWLLiteralMatcher(IMatcher<? super String> literalMatcher, IMatcher<? super String> languageMatcher,
			IMatcher<? super OWLDatatype> datatypeMatcher) {
		this.literalMatcher = literalMatcher;
		this.languageMatcher = languageMatcher;
		this.datatypeMatcher = datatypeMatcher;
	}

	@Override
	public boolean match(OWLLiteral literal, Map<String, Object> map) {
		return literalMatcher.match(literal.getLiteral(), map) && languageMatcher.match(literal.getLang(), map)
				&& datatypeMatcher.match(literal.getDatatype(), map);
	}

	@Override
	public Class<?> getType() {
		return OWLLiteral.class;
	}

	@Override
	public String toString() {
		return "OWLLiteralMatcher (" + literalMatcher.toString() + "@" + languageMatcher.toString() + "^^"
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
		if (obj instanceof OWLLiteralMatcher) {
			OWLLiteralMatcher other = (OWLLiteralMatcher) obj;
			return literalMatcher.equals(other.literalMatcher) && languageMatcher.equals(other.languageMatcher)
					&& datatypeMatcher.equals(other.datatypeMatcher);
		} else {
			return false;
		}
	}

	@Override
	public int hashCode() {
		return Objects.hash(literalMatcher, languageMatcher, datatypeMatcher);
	}

}
