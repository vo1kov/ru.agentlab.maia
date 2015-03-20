package ru.agentlab.maia

import java.util.List
import java.util.Properties

interface IMessage {

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String ACCEPT_PROPOSAL = "ACCEPT_PROPOSAL"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String AGREE = "AGREE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String CANCEL = "CANCEL"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String CFP = "CFP"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String CONFIRM = "CONFIRM"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String DISCONFIRM = "DISCONFIRM"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String FAILURE = "FAILURE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String INFORM = "INFORM"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String INFORM_IF = "INFORM_IF"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String INFORM_REF = "INFORM_REF"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String NOT_UNDERSTOOD = "NOT_UNDERSTOOD"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String PROPOSE = "PROPOSE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String QUERY_IF = "QUERY_IF"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String QUERY_REF = "QUERY_REF"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String REFUSE = "REFUSE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String REJECT_PROPOSAL = "REJECT_PROPOSAL"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String REQUEST = "REQUEST"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String REQUEST_WHEN = "REQUEST_WHEN"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String REQUEST_WHENEVER = "REQUEST_WHENEVER"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String SUBSCRIBE = "SUBSCRIBE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String PROXY = "PROXY"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String PROPAGATE = "PROPAGATE"

	/** 
	 * Constant identifying the FIPA performative *
	 */
	val static String UNKNOWN = "UNKNOWN"

	def IAgentId getSender()

	def void setSender(IAgentId sender)

	def List<IAgentId> getReceivers()

	def void setReceivers(List<IAgentId> receivers)

	def List<IAgentId> getReplyTo()

	def void setReplyTo(List<IAgentId> replyTo)

	def String getContent()

	def void setContent(String content)

	def byte[] getByteSequenceContent()

	def void setByteSequenceContent(byte[] byteSequenceContent)

	def String getReplyWith()

	def void setReplyWith(String reply_with)

	def String getInReplyTo()

	def void setInReplyTo(String inReplyTo)

	def String getEncoding()

	def void setEncoding(String encoding)

	def String getLanguage()

	def void setLanguage(String language)

	def String getOntology()

	def void setOntology(String ontology)

	def long getReplyByInMillisec()

	def void setReplyByInMillisec(long replyByInMillisec)

	def String getProtocol()

	def void setProtocol(String protocol)

	def String getConversationId()

	def void setConversationId(String conversationId)

	def Properties getUserDefinedProps()

	def void setUserDefinedProps(Properties userDefinedProps)

	def long getPostTimeStamp()

	def void setPostTimeStamp(long postTimeStamp)

	def IEnvelope getEnvelope()

	def void setEnvelope(IEnvelope envelope)

}