package ru.agentlab.maia.agent.belief.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLPropertyAssertionObject;

import ru.agentlab.maia.IEventMatcher;
import ru.agentlab.maia.TypeSafeEventMatcher;

public class OWLPropertyAssertionObjectIsLiteral extends TypeSafeEventMatcher<OWLPropertyAssertionObject> {

	IEventMatcher<? super OWLLiteral> matcher;

	public OWLPropertyAssertionObjectIsLiteral(IEventMatcher<? super OWLLiteral> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	protected boolean matchesSafely(OWLPropertyAssertionObject object, Map<String, Object> values) {
		return (object instanceof OWLLiteral) && matcher.matches((OWLLiteral) object, values);
	}

}
