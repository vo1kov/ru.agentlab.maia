package ru.agentlab.maia.io.queue.arrayblocking

import javax.annotation.PostConstruct
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.messaging.queue.IMessageQueue
import ru.agentlab.maia.messaging.queue.IMessageQueueFactory

class ArrayBlockingMessageQueueFactory implements IMessageQueueFactory {

	override createMessageQueue(IMaiaContext context) {
		val injector = context.get(IMaiaContextInjector)
		val result = injector.make(ArrayBlockingMessageQueue, context)
		injector.invoke(result, PostConstruct, context, null)
		context.set(IMessageQueue, result)
		return result
	}

}