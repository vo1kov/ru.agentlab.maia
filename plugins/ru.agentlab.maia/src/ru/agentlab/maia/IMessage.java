/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

import java.util.List;
import java.util.Properties;
import java.util.UUID;

@SuppressWarnings("all")
public interface IMessage {
	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String ACCEPT_PROPOSAL = "ACCEPT_PROPOSAL";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String AGREE = "AGREE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String CANCEL = "CANCEL";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String CFP = "CFP";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String CONFIRM = "CONFIRM";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String DISCONFIRM = "DISCONFIRM";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String FAILURE = "FAILURE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String INFORM = "INFORM";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String INFORM_IF = "INFORM_IF";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String INFORM_REF = "INFORM_REF";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String NOT_UNDERSTOOD = "NOT_UNDERSTOOD";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String PROPOSE = "PROPOSE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String QUERY_IF = "QUERY_IF";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String QUERY_REF = "QUERY_REF";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String REFUSE = "REFUSE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String REJECT_PROPOSAL = "REJECT_PROPOSAL";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String REQUEST = "REQUEST";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String REQUEST_WHEN = "REQUEST_WHEN";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String REQUEST_WHENEVER = "REQUEST_WHENEVER";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String SUBSCRIBE = "SUBSCRIBE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String PROXY = "PROXY";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String PROPAGATE = "PROPAGATE";

	/**
	 * Constant identifying the FIPA performative
	 */
	public final static String UNKNOWN = "UNKNOWN";

	UUID getSender();

	void setSender(final UUID sender);

	List<UUID> getReceivers();

	void setReceivers(final List<UUID> receivers);

	List<String> getReplyTo();

	void setReplyTo(final List<String> replyTo);

	String getContent();

	void setContent(final String content);

	byte[] getByteSequenceContent();

	void setByteSequenceContent(final byte[] byteSequenceContent);

	String getReplyWith();

	void setReplyWith(final String reply_with);

	String getInReplyTo();

	void setInReplyTo(final String inReplyTo);

	String getEncoding();

	void setEncoding(final String encoding);

	String getLanguage();

	void setLanguage(final String language);

	String getOntology();

	void setOntology(final String ontology);

	long getReplyByInMillisec();

	void setReplyByInMillisec(final long replyByInMillisec);

	String getProtocol();

	void setProtocol(final String protocol);

	String getConversationId();

	void setConversationId(final String conversationId);

	Properties getUserDefinedProps();

	void setUserDefinedProps(final Properties userDefinedProps);

	long getPostTimeStamp();

	void setPostTimeStamp(final long postTimeStamp);

	String getPerformative();

	void setPerformative(final String performative);
	
	IMessage createReply();
}
