package ru.agentlab.maia.internal.messaging

import java.util.ArrayList
import java.util.List
import java.util.Properties
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageEnvelope

class Message implements IMessage {

	@Accessors
	private IAgentId sender

	@Accessors
	private List<IAgentId> receivers = new ArrayList<IAgentId>

	@Accessors
	private List<IAgentId> replyTo = new ArrayList<IAgentId>

	@Accessors
	private String content

	@Accessors
	private byte[] byteSequenceContent

	@Accessors
	private String replyWith

	@Accessors
	private String inReplyTo

	@Accessors
	private String encoding

	@Accessors
	private String language

	@Accessors
	private String ontology

	@Accessors
	private long replyByInMillisec = 0

	@Accessors
	private String protocol

	@Accessors
	private String conversationId

	@Accessors
	private Properties userDefinedProps

	@Accessors
	private long postTimeStamp = -1

	@Accessors
	private IMessageEnvelope envelope

}