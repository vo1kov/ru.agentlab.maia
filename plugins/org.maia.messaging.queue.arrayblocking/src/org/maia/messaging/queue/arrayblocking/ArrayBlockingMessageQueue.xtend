package org.maia.messaging.queue.arrayblocking

import java.util.concurrent.ArrayBlockingQueue
import org.maia.messaging.IMessage
import org.maia.messaging.matching.IMessageTemplate
import org.maia.messaging.queue.IMessageQueue

/**
 * <code>IMessageQueue</code> implementation based on 
 * {@link ArrayBlockingQueue ArrayBlockingQueue}
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ArrayBlockingMessageQueue implements IMessageQueue {

	val queue = new ArrayBlockingQueue<IMessage>(1024)

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