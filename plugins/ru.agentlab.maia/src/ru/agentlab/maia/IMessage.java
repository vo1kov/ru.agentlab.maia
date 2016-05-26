/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

@SuppressWarnings("all")
public interface IMessage {
	/**
	 * Constant identifying the FIPA performative
	 */
	String ACCEPT_PROPOSAL = "ACCEPT_PROPOSAL";

	/**
	 * Constant identifying the FIPA performative
	 */
	String AGREE = "AGREE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String CANCEL = "CANCEL";

	/**
	 * Constant identifying the FIPA performative
	 */
	String CFP = "CFP";

	/**
	 * Constant identifying the FIPA performative
	 */
	String CONFIRM = "CONFIRM";

	/**
	 * Constant identifying the FIPA performative
	 */
	String DISCONFIRM = "DISCONFIRM";

	/**
	 * Constant identifying the FIPA performative
	 */
	String FAILURE = "FAILURE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String INFORM = "INFORM";

	/**
	 * Constant identifying the FIPA performative
	 */
	String INFORM_IF = "INFORM_IF";

	/**
	 * Constant identifying the FIPA performative
	 */
	String INFORM_REF = "INFORM_REF";

	/**
	 * Constant identifying the FIPA performative
	 */
	String NOT_UNDERSTOOD = "NOT_UNDERSTOOD";

	/**
	 * Constant identifying the FIPA performative
	 */
	String PROPOSE = "PROPOSE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String QUERY_IF = "QUERY_IF";

	/**
	 * Constant identifying the FIPA performative
	 */
	String QUERY_REF = "QUERY_REF";

	/**
	 * Constant identifying the FIPA performative
	 */
	String REFUSE = "REFUSE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String REJECT_PROPOSAL = "REJECT_PROPOSAL";

	/**
	 * Constant identifying the FIPA performative
	 */
	String REQUEST = "REQUEST";

	/**
	 * Constant identifying the FIPA performative
	 */
	String REQUEST_WHEN = "REQUEST_WHEN";

	/**
	 * Constant identifying the FIPA performative
	 */
	String REQUEST_WHENEVER = "REQUEST_WHENEVER";

	/**
	 * Constant identifying the FIPA performative
	 */
	String SUBSCRIBE = "SUBSCRIBE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String PROXY = "PROXY";

	/**
	 * Constant identifying the FIPA performative
	 */
	String PROPAGATE = "PROPAGATE";

	/**
	 * Constant identifying the FIPA performative
	 */
	String UNKNOWN = "UNKNOWN";

	UUID getSender();

	void setSender(UUID sender);

	List<UUID> getReceivers();

	void setReceivers(List<UUID> receivers);

	List<UUID> getReplyTo();

	void setReplyTo(List<UUID> replyTo);

	String getContent();

	void setContent(String content);

	byte[] getByteSequenceContent();

	void setByteSequenceContent(byte[] byteSequenceContent);

	String getReplyWith();

	void setReplyWith(String reply_with);

	String getInReplyTo();

	void setInReplyTo(String inReplyTo);

	String getEncoding();

	void setEncoding(String encoding);

	String getLanguage();

	void setLanguage(String language);

	String getOntology();

	void setOntology(String ontology);

	LocalDateTime getReplyBy();

	void setReplyBy(LocalDateTime replyByInMillisec);

	String getProtocol();

	void setProtocol(String protocol);

	String getConversationId();

	void setConversationId(String conversationId);

	Properties getUserDefinedProps();

	void setUserDefinedProps(Properties userDefinedProps);

	LocalDateTime getPostTimeStamp();

	void setPostTimeStamp(LocalDateTime postTimeStamp);

	String getPerformative();

	void setPerformative(String performative);
	
	IMessage createReply();
}
