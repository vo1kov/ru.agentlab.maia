package ru.agentlab.maia.agent.match;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import ru.agentlab.maia.IMessage;

public class MessageMatcher implements IMatcher<IMessage> {

	private UUID sender;

	private List<UUID> receivers = new ArrayList<UUID>();

	private List<String> replyTo = new ArrayList<String>();

	private String content;

	private byte[] byteSequenceContent;

	private String replyWith;

	private String inReplyTo;

	private String encoding;

	private String language;

	private String ontology;

	private String performative;

	private long replyByInMillisec = 0;

	private String protocol;

	private String conversationId;

	private long postTimeStamp = -1;

	@Override
	public boolean match(IMessage object, IUnifier unifier) {
		return false;
	}

	public UUID getSender() {
		return sender;
	}

	public void setSender(UUID sender) {
		this.sender = sender;
	}

	public List<UUID> getReceivers() {
		return receivers;
	}

	public void setReceivers(List<UUID> receivers) {
		this.receivers = receivers;
	}

	public List<String> getReplyTo() {
		return replyTo;
	}

	public void setReplyTo(List<String> replyTo) {
		this.replyTo = replyTo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public byte[] getByteSequenceContent() {
		return byteSequenceContent;
	}

	public void setByteSequenceContent(byte[] byteSequenceContent) {
		this.byteSequenceContent = byteSequenceContent;
	}

	public String getReplyWith() {
		return replyWith;
	}

	public void setReplyWith(String replyWith) {
		this.replyWith = replyWith;
	}

	public String getInReplyTo() {
		return inReplyTo;
	}

	public void setInReplyTo(String inReplyTo) {
		this.inReplyTo = inReplyTo;
	}

	public String getEncoding() {
		return encoding;
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getOntology() {
		return ontology;
	}

	public void setOntology(String ontology) {
		this.ontology = ontology;
	}

	public String getPerformative() {
		return performative;
	}

	public void setPerformative(String performative) {
		this.performative = performative;
	}

	public long getReplyByInMillisec() {
		return replyByInMillisec;
	}

	public void setReplyByInMillisec(long replyByInMillisec) {
		this.replyByInMillisec = replyByInMillisec;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public String getConversationId() {
		return conversationId;
	}

	public void setConversationId(String conversationId) {
		this.conversationId = conversationId;
	}

	public long getPostTimeStamp() {
		return postTimeStamp;
	}

	public void setPostTimeStamp(long postTimeStamp) {
		this.postTimeStamp = postTimeStamp;
	}

	@Override
	public Class<?> getType() {
		return IMessage.class;
	}

}
