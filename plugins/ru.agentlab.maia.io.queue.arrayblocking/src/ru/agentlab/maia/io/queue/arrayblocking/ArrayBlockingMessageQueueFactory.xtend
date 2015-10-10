package ru.agentlab.maia.io.queue.arrayblocking

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.messaging.queue.IMessageQueue
import ru.agentlab.maia.messaging.queue.IMessageQueueFactory

class ArrayBlockingMessageQueueFactory implements IMessageQueueFactory {

	override createMessageQueue(IContext context) {
		val injector = context.getService(IInjector)
		val result = injector.make(ArrayBlockingMessageQueue)
		injector.invoke(result, PostConstruct, null)
		context.putService(IMessageQueue, result)
		return result
	}

}