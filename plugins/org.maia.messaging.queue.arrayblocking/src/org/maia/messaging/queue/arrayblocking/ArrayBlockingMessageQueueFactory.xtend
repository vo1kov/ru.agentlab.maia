package org.maia.messaging.queue.arrayblocking

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.annotations.Optional
import org.maia.messaging.queue.IMessageQueue
import org.maia.messaging.queue.IMessageQueueFactory

class ArrayBlockingMessageQueueFactory implements IMessageQueueFactory {

	@Inject @Optional
	IEclipseContext context

	override createMessageQueue() {
		if (context == null) {
			throw new IllegalArgumentException(
				"Unknown context, use [createMessageQueue(IEclipseContext ctx)] method instead")
		}
		return context.createMessageQueue
	}

	override createMessageQueue(IEclipseContext ctx) {
		val result = ContextInjectionFactory.make(ArrayBlockingMessageQueue, ctx)
		ContextInjectionFactory.invoke(result, PostConstruct, ctx, null)
		ctx.set(IMessageQueue, result)
		return result
	}

}