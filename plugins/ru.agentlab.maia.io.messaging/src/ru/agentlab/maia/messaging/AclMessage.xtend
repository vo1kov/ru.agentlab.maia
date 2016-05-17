package ru.agentlab.maia.messaging

import java.util.ArrayList
import java.util.List
import java.util.Properties
import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.messaging.IMessageEnvelope
import ru.agentlab.maia.IMessage

@Accessors
class AclMessage implements IMessage {

	private UUID sender

	private List<UUID> receivers = new ArrayList<UUID>

	private List<String> replyTo = new ArrayList<String>

	private String content

	private byte[] byteSequenceContent

	private String replyWith

	private String inReplyTo

	private String encoding

	private String language

	private String ontology

	private String performative

	private long replyByInMillisec = 0

	private String protocol

	private String conversationId

	private Properties userDefinedProps

	private long postTimeStamp = -1

	private IMessageEnvelope envelope
	
	override createReply() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
