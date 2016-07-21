package ru.agentlab.maia.message.match;

import java.time.LocalDateTime;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.IMessage;

public class AclMessageHasReplyBy extends TypeSafeMatcher<IMessage> {

	Matcher<? super LocalDateTime> matcher;

	public AclMessageHasReplyBy(Matcher<? super LocalDateTime> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has replyBy ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getReplyBy());
	}

}
