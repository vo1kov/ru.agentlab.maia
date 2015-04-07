package org.maia.messaging.acl

import java.util.ArrayList
import java.util.List
import java.util.Properties
import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.messaging.IMessage
import org.maia.messaging.IMessageEnvelope

@Accessors
class AclMessage implements IMessage {

	private String sender

	private List<String> receivers = new ArrayList<String>

	private List<String> replyTo = new ArrayList<String>

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