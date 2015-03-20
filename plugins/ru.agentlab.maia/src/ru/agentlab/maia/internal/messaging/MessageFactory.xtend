package ru.agentlab.maia.internal.messaging

import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class MessageFactory implements IMessageFactory {

	override IMessage create() {
		return new Message
	}
}