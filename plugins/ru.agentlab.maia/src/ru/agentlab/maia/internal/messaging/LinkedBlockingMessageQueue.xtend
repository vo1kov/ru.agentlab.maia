package ru.agentlab.maia.internal.messaging

import java.util.concurrent.LinkedBlockingQueue
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.matching.IMessageTemplate

/**
 * <code>IMessageQueue</code> implementation based on 
 * {@link LinkedBlockingQueue LinkedBlockingQueue}
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class LinkedBlockingMessageQueue implements IMessageQueue {

	val queue = new LinkedBlockingQueue<IMessage>(1024)

	override isEmpty() {
		queue.isEmpty
	}

	override int size() {
		queue.size
	}

	override void addFirst(IMessage msg) {
		queue.add(msg)
	}

	override void addLast(IMessage msg) {
		throw new UnsupportedOperationException("LIFO is not supported")
	}

	override IMessage receive(IMessageTemplate pattern) {
		synchronized (queue) {
			val message = queue.findFirst[pattern.match(it)]
			if (message != null) {
				queue.remove(message)
			}
			return message
		}
	}

}