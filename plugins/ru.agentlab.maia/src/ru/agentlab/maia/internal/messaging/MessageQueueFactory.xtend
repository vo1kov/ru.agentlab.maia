package ru.agentlab.maia.internal.messaging

import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory

class MessageQueueFactory implements IMessageQueueFactory {
	
	override IMessageQueue get() {
		return new MessageQueue()
	}

}
