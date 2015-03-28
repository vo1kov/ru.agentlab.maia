/** 
 * JADE - Java IAgent DEvelopment Framework is a framework to develop 
 * multi-agent systems in compliance with the FIPA specifications.
 * Copyright (C) 2000 CSELT S.p.A. 
 * GNU Lesser General Public License
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation, 
 * version 2.1 of the License. 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 */
package ru.agentlab.maia.internal.messaging

import java.util.LinkedList
import org.eclipse.xtend.lib.annotations.Accessors
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.matching.IMessageTemplate

/** 
 * @author Giovanni Rimassa - Universita` di Parma
 * @version $Date: 2006-01-12 13:21:47 +0100 (gio, 12 gen 2006) $ $Revision:
 * 5847 $
 */
class MessageQueue implements IMessageQueue {

	static Logger LOGGER = LoggerFactory.getLogger(MessageQueue)

	LinkedList<IMessage> list = new LinkedList<IMessage>

	@Accessors
	int maxSize

	new(int size) {
		maxSize = size
		list = new LinkedList()
	}

	new() {
		this(0)
	}

	override boolean isEmpty() {
		return list.isEmpty()
	}

	override void setMaxSize(int newSize) throws IllegalArgumentException {
		if (newSize < 0) {
			throw new IllegalArgumentException("Invalid MsgQueue size")
		}
		maxSize = newSize
	}

	/** 
	 * @return the number of messages currently in the queue
	 */
	override int size() {
		return list.size()
	}

	override void addFirst(IMessage msg) {
		if ((maxSize != 0) && (list.size() >= maxSize)) {
			list.removeFirst() // FIFO replacement policy
		}
		list.addFirst(msg)
	}

	override void addLast(IMessage msg) {
		if ((maxSize != 0) && (list.size() >= maxSize)) {
			list.removeFirst() // FIFO replacement policy
			LOGGER.error("Message queue size exceeded. Message discarded!!!!!")
		}
		list.addLast(msg)
	}

	// This is just for the MIDP implementation where iterator.remove() is
	// not supported.
	// We don't surround it with preprocessor directives to avoid making the
	// code unreadable
	override IMessage receive(IMessageTemplate pattern) {
		val message = list.findFirst[pattern.match(it)]
		if (message != null) {
			list.remove(message)
		}
		return message
	}

	override void copyTo(LinkedList<IMessage> messages) {
		list.forEach [
			messages.add(it)
		]
	}

	def package Object[] getAllMessages() {
		return list.toArray()
	}

	def package void cleanOldMessages(long maxTime, IMessageTemplate pattern) {
		val now = System.currentTimeMillis()

		val oldMessages = list.filter [
			val postTime = postTimeStamp
			return postTime > 0 && ((now - postTime) > maxTime)
		]
		val neededMessages = oldMessages.filter [
			if (pattern == null) {
				pattern.match(it)
			} else {
				true
			}
		]
		list.removeAll(neededMessages)
	}

}