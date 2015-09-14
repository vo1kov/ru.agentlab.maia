package ru.agentlab.maia.io.queue.linkedblocking

import javax.annotation.PostConstruct
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.messaging.queue.IMessageQueue
import ru.agentlab.maia.messaging.queue.IMessageQueueFactory

class LinkedBlockingMessageQueueFactory implements IMessageQueueFactory {

	override createMessageQueue(IMaiaContext context) {
		val injector = context.getService(IMaiaContextInjector)
		val result = injector.make(LinkedBlockingMessageQueue)
		injector.invoke(result, PostConstruct, null)
		context.putService(IMessageQueue, result)
		return result
	}

}