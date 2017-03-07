package ru.agentlab.maia.service.message.match;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import ru.agentlab.maia.IMessage;

public class AclMessageHasConversationId extends TypeSafeMatcher<IMessage> {

	Matcher<? super String> matcher;

	public AclMessageHasConversationId(Matcher<? super String> matcher) {
		super();
		this.matcher = matcher;
	}

	@Override
	public void describeTo(Description description) {
		description.appendText("has conversationId ").appendDescriptionOf(matcher);
	}

	@Override
	protected boolean matchesSafely(IMessage message) {
		return matcher.matches(message.getConversationId());
	}

}
