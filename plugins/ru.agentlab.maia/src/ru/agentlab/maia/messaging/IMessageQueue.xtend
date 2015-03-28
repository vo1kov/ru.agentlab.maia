/** 
 * JADE - Java Agent DEvelopment Framework is a framework to develop 
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
package ru.agentlab.maia.messaging

import java.util.LinkedList
import ru.agentlab.maia.messaging.matching.IMessageTemplate

/** 
 * The interface to be implemented by agent message queue implementations
 * @see Agent#createMessageQueue()
 * @author Arend Freije
 */
interface IMessageQueue {

	/** 
	 * Add a message to the front of this queue.
	 */
	def void addFirst(IMessage msg)

	/** 
	 * Add a message to the end of this queue.
	 */
	def void addLast(IMessage msg)

	/** 
	 * Return the maximum size of this queue.
	 * This queue may remove old messages to prevent
	 * exeding the maximum size.
	 */
	def int getMaxSize()

	/** 
	 * Set the maximum size of this queue.
	 * This queue may remove old messages to prevent
	 * exeding the maximum size.
	 */
	def void setMaxSize(int newSize)

	/** 
	 * Return true when this queue contains no messages.
	 */
	def boolean isEmpty()

	/** 
	 * Return and remove the first message that matches the
	 * specified message template.
	 */
	def IMessage receive(IMessageTemplate pattern)

	/** 
	 * Copy all messages to a given list.
	 */
	def void copyTo(LinkedList<IMessage> list)

	/** 
	 * @return the number of messages
	 * currently in the queue
	 */
	def int size()

}
