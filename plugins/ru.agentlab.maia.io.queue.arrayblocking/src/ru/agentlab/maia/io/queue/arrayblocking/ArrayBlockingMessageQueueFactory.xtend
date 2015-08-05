package ru.agentlab.maia.io.queue.arrayblocking

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.messaging.queue.IMessageQueue
import ru.agentlab.maia.messaging.queue.IMessageQueueFactory

class ArrayBlockingMessageQueueFactory implements IMessageQueueFactory {

	override createMessageQueue(IMaiaContext context) {
		val injector = context.get(IMaiaContextInjector)
		val result = injector.make(ArrayBlockingMessageQueue)
		injector.invoke(result, PostConstruct, null)
		context.set(IMessageQueue, result)
		return result
	}

}