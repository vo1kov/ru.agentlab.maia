package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyAssertionObjectIsIndividual extends TypeSafeEventMatcher<OWLPropertyAssertionObject> {

	IEventMatcher<? super OWLIndividual> matcher;

	public OWLPropertyAssertionObjectIsIndividual(IEventMatcher<? super OWLIndividual> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionObject object, Map<String, Object> values) {
		return (object instanceof OWLIndividual) && matcher.matches((OWLIndividual) object, values);
	}

}
