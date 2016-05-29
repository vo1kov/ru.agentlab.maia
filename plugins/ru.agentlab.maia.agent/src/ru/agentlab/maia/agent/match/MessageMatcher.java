package ru.agentlab.maia.agent.match;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import ru.agentlab.maia.IMatcher;
import ru.agentlab.maia.IMessage;

public class MessageMatcher implements IMatcher<IMessage> {

	private IMatcher<? super UUID> senderMatcher;

	private IMatcher<? super List<UUID>> receiversMatcher;

	private IMatcher<? super List<UUID>> replyToMatcher;

	private IMatcher<? super String> contentMatcher;

	private IMatcher<? super String> replyWithMatcher;

	private IMatcher<? super String> inReplyToMatcher;

	private IMatcher<? super String> encodingMatcher;

	private IMatcher<? super String> languageMatcher;

	private IMatcher<? super String> ontologyMatcher;

	private IMatcher<? super String> performativeMatcher;

	private IMatcher<? super LocalDateTime> replyByMatcher;

	private IMatcher<? super String> protocolMatcher;

	private IMatcher<? super String> conversationIdMatcher;

	private IMatcher<? super LocalDateTime> postTimeStampMatcher;

	@Override
	public boolean match(IMessage object, Map<String, Object> map) {
		if (senderMatcher != null && !senderMatcher.match(object.getSender(), map)) {
			return false;
		}
		if (receiversMatcher != null && !receiversMatcher.match(object.getReceivers(), map)) {
			return false;
		}
		if (replyToMatcher != null && !replyToMatcher.match(object.getReplyTo(), map)) {
			return false;
		}
		if (contentMatcher != null && !contentMatcher.match(object.getContent(), map)) {
			return false;
		}
		if (replyWithMatcher != null && !replyWithMatcher.match(object.getReplyWith(), map)) {
			return false;
		}
		if (inReplyToMatcher != null && !inReplyToMatcher.match(object.getInReplyTo(), map)) {
			return false;
		}
		if (encodingMatcher != null && !encodingMatcher.match(object.getEncoding(), map)) {
			return false;
		}
		if (languageMatcher != null && !languageMatcher.match(object.getLanguage(), map)) {
			return false;
		}
		if (ontologyMatcher != null && !ontologyMatcher.match(object.getOntology(), map)) {
			return false;
		}
		if (performativeMatcher != null && !performativeMatcher.match(object.getPerformative(), map)) {
			return false;
		}
		if (replyByMatcher != null && !replyByMatcher.match(object.getReplyBy(), map)) {
			return false;
		}
		if (protocolMatcher != null && !protocolMatcher.match(object.getProtocol(), map)) {
			return false;
		}
		if (conversationIdMatcher != null && !conversationIdMatcher.match(object.getConversationId(), map)) {
			return false;
		}
		if (postTimeStampMatcher != null && !postTimeStampMatcher.match(object.getPostTimeStamp(), map)) {
			return false;
		}
		return false;
	}

	public IMatcher<? super UUID> getSenderMatcher() {
		return senderMatcher;
	}

	public void setSenderMatcher(IMatcher<? super UUID> senderMatcher) {
		this.senderMatcher = senderMatcher;
	}

	public IMatcher<? super List<UUID>> getReceiversMatcher() {
		return receiversMatcher;
	}

	public void setReceiversMatcher(IMatcher<? super List<UUID>> receiversMatcher) {
		this.receiversMatcher = receiversMatcher;
	}

	public IMatcher<? super List<UUID>> getReplyToMatcher() {
		return replyToMatcher;
	}

	public void setReplyToMatcher(IMatcher<? super List<UUID>> replyToMatcher) {
		this.replyToMatcher = replyToMatcher;
	}

	public IMatcher<? super String> getContentMatcher() {
		return contentMatcher;
	}

	public void setContentMatcher(IMatcher<? super String> contentMatcher) {
		this.contentMatcher = contentMatcher;
	}

	public IMatcher<? super String> getReplyWithMatcher() {
		return replyWithMatcher;
	}

	public void setReplyWithMatcher(IMatcher<? super String> replyWithMatcher) {
		this.replyWithMatcher = replyWithMatcher;
	}

	public IMatcher<? super String> getInReplyToMatcher() {
		return inReplyToMatcher;
	}

	public void setInReplyToMatcher(IMatcher<? super String> inReplyToMatcher) {
		this.inReplyToMatcher = inReplyToMatcher;
	}

	public IMatcher<? super String> getEncodingMatcher() {
		return encodingMatcher;
	}

	public void setEncodingMatcher(IMatcher<? super String> encodingMatcher) {
		this.encodingMatcher = encodingMatcher;
	}

	public IMatcher<? super String> getLanguageMatcher() {
		return languageMatcher;
	}

	public void setLanguageMatcher(IMatcher<? super String> languageMatcher) {
		this.languageMatcher = languageMatcher;
	}

	public IMatcher<? super String> getOntologyMatcher() {
		return ontologyMatcher;
	}

	public void setOntologyMatcher(IMatcher<? super String> ontologyMatcher) {
		this.ontologyMatcher = ontologyMatcher;
	}

	public IMatcher<? super String> getPerformativeMatcher() {
		return performativeMatcher;
	}

	public void setPerformativeMatcher(IMatcher<? super String> performativeMatcher) {
		this.performativeMatcher = performativeMatcher;
	}

	public IMatcher<? super LocalDateTime> getReplyByMatcher() {
		return replyByMatcher;
	}

	public void setReplyByMatcher(IMatcher<? super LocalDateTime> replyByMatcher) {
		this.replyByMatcher = replyByMatcher;
	}

	public IMatcher<? super String> getProtocolMatcher() {
		return protocolMatcher;
	}

	public void setProtocolMatcher(IMatcher<? super String> protocol) {
		this.protocolMatcher = protocol;
	}

	public IMatcher<? super String> getConversationIdMatcher() {
		return conversationIdMatcher;
	}

	public void setConversationIdMatcher(IMatcher<? super String> conversationId) {
		this.conversationIdMatcher = conversationId;
	}

	public IMatcher<? super LocalDateTime> getPostTimeStamp() {
		return postTimeStampMatcher;
	}

	public void setPostTimeStamp(IMatcher<? super LocalDateTime> postTimeStampMatcher) {
		this.postTimeStampMatcher = postTimeStampMatcher;
	}

	@Override
	public Class<IMessage> getType() {
		return IMessage.class;
	}

}
