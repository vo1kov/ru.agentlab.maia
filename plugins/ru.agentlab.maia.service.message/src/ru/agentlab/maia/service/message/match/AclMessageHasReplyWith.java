package ru.agentlab.maia.service.message.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.IMessage;

public class AclMessageHasReplyWith extends TypeSafeMatcher<IMessage> {

	Matcher<? super String> matcher;

	public AclMessageHasReplyWith(Matcher<? super String> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has replyWith ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getReplyWith());
	}

}
