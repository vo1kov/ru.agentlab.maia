package ru.agentlab.maia.hamcrest.message;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.IMessage;

public class AclMessageHasInReplyTo extends TypeSafeMatcher<IMessage> {

	Matcher<? super String> matcher;

	public AclMessageHasInReplyTo(Matcher<? super String> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has inReplyTo ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getInReplyTo());
	}

}
