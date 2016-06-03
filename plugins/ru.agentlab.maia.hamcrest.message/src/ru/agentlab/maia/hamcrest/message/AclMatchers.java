package ru.agentlab.maia.hamcrest.message;

import java.time.LocalDateTime;
import java.util.UUID;

import org.hamcrest.Matcher;

import ru.agentlab.maia.IMessage;

public class AclMatchers {

	public static Matcher<IMessage> hasContent(Matcher<? super String> matcher) {
		return new AclMessageHasContent(matcher);
	}

	public static Matcher<IMessage> hasConversationId(Matcher<? super String> matcher) {
		return new AclMessageHasConversationId(matcher);
	}

	public static Matcher<IMessage> hasEncoding(Matcher<? super String> matcher) {
		return new AclMessageHasEncoding(matcher);
	}

	public static Matcher<IMessage> hasInReplyTo(Matcher<? super String> matcher) {
		return new AclMessageHasInReplyTo(matcher);
	}

	public static Matcher<IMessage> hasLanguage(Matcher<? super String> matcher) {
		return new AclMessageHasLanguage(matcher);
	}

	public static Matcher<IMessage> hasOntology(Matcher<? super String> matcher) {
		return new AclMessageHasOntology(matcher);
	}

	public static Matcher<IMessage> hasPerformative(Matcher<? super String> matcher) {
		return new AclMessageHasPerformative(matcher);
	}

	public static Matcher<IMessage> hasPostTimeStamp(Matcher<? super LocalDateTime> matcher) {
		return new AclMessageHasPostTimeStamp(matcher);
	}

	public static Matcher<IMessage> hasProtocol(Matcher<? super String> matcher) {
		return new AclMessageHasProtocol(matcher);
	}

	public static Matcher<IMessage> hasReceivers(Matcher<? super Iterable<UUID>> matcher) {
		return new AclMessageHasReceivers(matcher);
	}

	public static Matcher<IMessage> hasReplyBy(Matcher<? super LocalDateTime> matcher) {
		return new AclMessageHasReplyBy(matcher);
	}

	public static Matcher<IMessage> hasReplyTo(Matcher<? super Iterable<UUID>> matcher) {
		return new AclMessageHasReplyTo(matcher);
	}

	public static Matcher<IMessage> hasReplyWith(Matcher<? super String> matcher) {
		return new AclMessageHasReplyWith(matcher);
	}

	public static Matcher<IMessage> hasSender(Matcher<? super UUID> matcher) {
		return new AclMessageHasSender(matcher);
	}

}