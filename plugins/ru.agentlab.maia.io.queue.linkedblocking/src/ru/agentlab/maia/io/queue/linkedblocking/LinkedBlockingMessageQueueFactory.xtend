package ru.agentlab.maia.io.queue.linkedblocking

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.messaging.queue.IMessageQueue
import ru.agentlab.maia.messaging.queue.IMessageQueueFactory

class LinkedBlockingMessageQueueFactory implements IMessageQueueFactory {

	override createMessageQueue(IMaiaContext context) {
		val injector = context.get(IMaiaContextInjector)
		val result = injector.make(LinkedBlockingMessageQueue, context)
		injector.invoke(result, PostConstruct, context, null)
		context.set(IMessageQueue, result)
		return result
	}

}