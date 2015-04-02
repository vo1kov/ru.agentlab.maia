package ru.agentlab.maia.internal.messaging

import java.util.ArrayList
import java.util.List
import java.util.Properties
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageEnvelope

@Accessors
class AclMessage implements IMessage {

	private IAgentId sender

	private List<IAgentId> receivers = new ArrayList<IAgentId>

	private List<IAgentId> replyTo = new ArrayList<IAgentId>

	private String content

	private byte[] byteSequenceContent

	private String replyWith

	private String inReplyTo

	private String encoding

	private String language

	private String ontology

	private long replyByInMillisec = 0

	private String protocol

	private String conversationId

	private Properties userDefinedProps

	private long postTimeStamp = -1

	private IMessageEnvelope envelope

}