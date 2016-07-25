package ru.agentlab.maia.message.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.message.IMessage;

public class AclMessageHasOntology extends TypeSafeMatcher<IMessage> {

	Matcher<? super String> matcher;

	public AclMessageHasOntology(Matcher<? super String> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has ontology ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getOntology());
	}

}
