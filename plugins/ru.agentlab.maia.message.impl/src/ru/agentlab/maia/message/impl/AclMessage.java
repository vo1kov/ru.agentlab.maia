package ru.agentlab.maia.message.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import ru.agentlab.maia.message.IMessage;

class AclMessage implements IMessage {

	private UUID sender;

	private List<UUID> receivers = new ArrayList<UUID>();

	private List<UUID> replyTo = new ArrayList<UUID>();

	private String content;

	private byte[] byteSequenceContent;

	private String replyWith;

	private String inReplyTo;

	private String encoding;

	private String language;

	private String ontology;

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

	public List<UUID> getReplyTo() {
		return replyTo;
	}

	public void setReplyTo(List<UUID> replyTo) {
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

	public LocalDateTime getReplyBy() {
		return replyBy;
	}

	public void setReplyBy(LocalDateTime replyBy) {
		this.replyBy = replyBy;
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

	public Properties getUserDefinedProps() {
		return userDefinedProps;
	}

	public void setUserDefinedProps(Properties userDefinedProps) {
		this.userDefinedProps = userDefinedProps;
	}

	public LocalDateTime getPostTimeStamp() {
		return postTimeStamp;
	}

	public void setPostTimeStamp(LocalDateTime postTimeStamp) {
		this.postTimeStamp = postTimeStamp;
	}

	private String performative;

	private LocalDateTime replyBy;

	private String protocol;

	private String conversationId;

	private Properties userDefinedProps;

	private LocalDateTime postTimeStamp;

}
