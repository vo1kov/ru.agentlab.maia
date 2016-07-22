package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLNamedObjectHasIRI extends TypeSafeEventMatcher<OWLNamedObject> {

	IEventMatcher<? super IRI> matcher;

	public OWLNamedObjectHasIRI(IEventMatcher<? super IRI> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLNamedObject named, Map<String, Object> values) {
		return matcher.matches(named.getIRI(), values);
	}

}
