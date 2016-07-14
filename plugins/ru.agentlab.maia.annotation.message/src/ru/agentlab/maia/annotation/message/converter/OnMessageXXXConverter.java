package ru.agentlab.maia.annotation.message.converter;

import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.CoreMatchers.equalTo;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasContent;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasConversationId;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasEncoding;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasInReplyTo;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasLanguage;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasOntology;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasPerformative;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasProtocol;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasReplyWith;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasSender;

import java.lang.annotation.Annotation;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.hamcrest.Matcher;

import ru.agentlab.maia.ConverterContext;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.IEventMatcherConverter;
import ru.agentlab.maia.annotation.Util;

public class OnMessageXXXConverter implements IEventMatcherConverter {

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * ru.agentlab.maia.plan.message.converter.IEventMatcherConverter#getMatcher
	 * (java.lang.annotation.Annotation, java.util.Map)
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@Override
	public Matcher<? super IMessage> getMatcher(ConverterContext context) {
		Annotation ann = context.getAnnotation();
		Map<String, Object> variables = context.getVariables();
		List<Matcher<? super IMessage>> matchers = new ArrayList<>();

		// performative
		String performative = Util.getMethodValue(ann, "performative", String.class);
		if (!performative.isEmpty()) {
			matchers.add(hasPerformative(equalTo(performative)));
		}

		// sender
		String sender = Util.getMethodValue(ann, "sender", String.class);
		if (!sender.isEmpty()) {
			matchers.add(hasSender(equalTo(UUID.fromString(sender))));
		}

		// receivers
		// TODO
		Matcher<? super List<UUID>> receiversMatcher;

		// replyTo
		// TODO
		Matcher<? super List<UUID>> replyToMatcher;

		// content
		String content = Util.getMethodValue(ann, "content", String.class);
		if (!content.isEmpty()) {
			matchers.add(hasContent(equalTo(performative)));
		}

		// replyWith
		String replyWith = Util.getMethodValue(ann, "replyWith", String.class);
		if (!replyWith.isEmpty()) {
			matchers.add(hasReplyWith(equalTo(performative)));
		}

		// inReplyTo
		String inReplyTo = Util.getMethodValue(ann, "inReplyTo", String.class);
		if (!inReplyTo.isEmpty()) {
			matchers.add(hasInReplyTo(equalTo(performative)));
		}

		// encoding
		String encoding = Util.getMethodValue(ann, "encoding", String.class);
		if (!encoding.isEmpty()) {
			matchers.add(hasEncoding(equalTo(performative)));
		}

		// language
		String language = Util.getMethodValue(ann, "language", String.class);
		if (!language.isEmpty()) {
			matchers.add(hasLanguage(equalTo(performative)));
		}

		// ontology
		String ontology = Util.getMethodValue(ann, "ontology", String.class);
		if (!ontology.isEmpty()) {
			matchers.add(hasOntology(equalTo(performative)));
		}

		// replyBy
		// TODO
		Matcher<? super LocalDateTime> replyByMatcher;

		// protocol
		String protocol = Util.getMethodValue(ann, "protocol", String.class);
		if (!protocol.isEmpty()) {
			matchers.add(hasProtocol(equalTo(performative)));
		}

		// conversationId
		String conversationId = Util.getMethodValue(ann, "conversationId", String.class);
		if (!conversationId.isEmpty()) {
			matchers.add(hasConversationId(equalTo(performative)));
		}

		// postTimeStamp
		// TODO
		Matcher<? super LocalDateTime> postTimeStampMatcher;

		return allOf(matchers.toArray(new Matcher[matchers.size()]));
	}

}
