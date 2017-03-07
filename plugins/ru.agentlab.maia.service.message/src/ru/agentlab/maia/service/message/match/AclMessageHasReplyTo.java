package ru.agentlab.maia.service.message.match;

import java.util.UUID;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.IMessage;

public class AclMessageHasReplyTo extends TypeSafeMatcher<IMessage> {

	Matcher<? super Iterable<UUID>> matcher;

	public AclMessageHasReplyTo(Matcher<? super Iterable<UUID>> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has replyTo ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getReplyTo());
	}

}
