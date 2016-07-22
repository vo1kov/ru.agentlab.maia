package ru.agentlab.maia.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyAssertionAxiomHasObject extends TypeSafeEventMatcher<OWLPropertyAssertionAxiom<?, ?>> {

	IEventMatcher<? super OWLPropertyAssertionObject> matcher;

	public OWLPropertyAssertionAxiomHasObject(IEventMatcher<? super OWLPropertyAssertionObject> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionAxiom<?, ?> axiom, Map<String, Object> values) {
		return matcher.matches(axiom.getObject(), values);
	}

}
