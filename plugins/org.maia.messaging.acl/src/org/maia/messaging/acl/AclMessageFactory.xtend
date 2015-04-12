package org.maia.messaging.acl

import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

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