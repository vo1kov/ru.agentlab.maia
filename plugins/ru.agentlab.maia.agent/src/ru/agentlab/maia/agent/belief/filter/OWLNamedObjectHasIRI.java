package ru.agentlab.maia.agent.belief.filter;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.agent.filter.IPlanEventFilter;
import ru.agentlab.maia.agent.filter.TypeSafeEventFilter;

public class OWLNamedObjectHasIRI extends TypeSafeEventFilter<OWLNamedObject> {

	IPlanEventFilter<? super IRI> matcher;

	public OWLNamedObjectHasIRI(IPlanEventFilter<? super IRI> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLNamedObject named, Map<String, Object> values) {
		return matcher.matches(named.getIRI(), values);
	}

}
