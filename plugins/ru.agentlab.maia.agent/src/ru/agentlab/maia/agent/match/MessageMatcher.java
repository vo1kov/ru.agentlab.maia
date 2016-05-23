package ru.agentlab.maia.agent.match;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
	public Class<?> getType() {
		return IMessage.class;
	}

}
