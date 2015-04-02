package ru.agentlab.maia.internal.messaging

import java.util.concurrent.ConcurrentLinkedDeque
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.matching.IMessageTemplate

class MessageQueue implements IMessageQueue {

	val queue = new ConcurrentLinkedDeque<IMessage>

	override isEmpty() {
		queue.isEmpty
	}

	override int size() {
		queue.size
	}

	override void addFirst(IMessage msg) {
		queue.addFirst(msg)
	}

	override void addLast(IMessage msg) {
		queue.addLast(msg)
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
	
	def void fireEvent(IMessage message){
		
	}

}