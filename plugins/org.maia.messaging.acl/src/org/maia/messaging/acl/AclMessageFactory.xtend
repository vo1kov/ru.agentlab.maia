package org.maia.messaging.acl

import org.maia.messaging.IMessage
import org.maia.messaging.IMessageFactory

class AclMessageFactory implements IMessageFactory {

	override IMessage create() {
		return new AclMessage
	}

	override createReply(IMessage message) {
		return create => [
			it.receivers += message.sender
			it.conversationId = message.conversationId
		]
	}

}