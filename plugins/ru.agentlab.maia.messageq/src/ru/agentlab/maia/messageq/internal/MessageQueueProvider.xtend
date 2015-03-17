package ru.agentlab.maia.messageq.internal

import ru.agentlab.maia.messageq.IMessageQueue
import ru.agentlab.maia.messageq.IMessageQueueProvider

class MessageQueueProvider implements IMessageQueueProvider {
	override IMessageQueue get() {
		return new MessageQueue()
	}

}
