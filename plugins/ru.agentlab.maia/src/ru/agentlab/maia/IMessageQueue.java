/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia;

/**
 * The interface to be implemented by agent message queue implementations
 * 
 * @see Agent#createMessageQueue()
 * @author Arend Freije
 */
@SuppressWarnings("all")
public interface IMessageQueue {
	/**
	 * Add a message to the front of this queue.
	 */
	void addFirst(final IMessage msg);

	/**
	 * Add a message to the end of this queue.
	 */
	void addLast(final IMessage msg);

	/**
	 * Return true when this queue contains no messages.
	 */
	boolean isEmpty();

	/**
	 * Return and remove the first message that matches the specified message
	 * template.
	 */
	IMessage receive();

	/**
	 * @return the number of messages currently in the queue
	 */
	int size();
}
