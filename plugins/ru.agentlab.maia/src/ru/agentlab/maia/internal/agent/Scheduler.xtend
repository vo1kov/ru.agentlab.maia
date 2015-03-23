/** 
 * JADE - Java Agent DEvelopment Framework is a framework to develop 
 * multi-agent systems in compliance with the FIPA specifications.
 * Copyright (C) 2000 CSELT S.p.A. 
 * GNU Lesser General Public License
 * This library is free software you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation, 
 * version 2.1 of the License. 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 */
package ru.agentlab.maia.internal.agent

import java.util.LinkedList
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour

/** 
 * Name: Scheduler
 * Responsibility and Collaborations:
 * + Selects the behaviour to execute. (IBehaviour)
 * + Holds together all the behaviours of an agent. (Agent, IBehaviour)
 * + Manages the resources needed to synchronize and execute agent behaviours,
 * such as thread pools, locks, etc.
 */
class Scheduler extends Thread implements IScheduler {

	val static LOGGER = LoggerFactory.getLogger(Scheduler)

	val readyBehaviours = new LinkedList<IBehaviour>

	val blockedBehaviours = new LinkedList<IBehaviour>

	private transient Object suspendLock = new Object
	private transient Object behavioursLock = new Object

	private int currentIndex = 0

	new(String name) {
		super(name)
	}

	/**
	 * Add a behaviour at the end of the behaviours queue.
	 * This can never change the index of the current behaviour.
	 * If the behaviours queue was empty notifies the embedded thread of
	 * the owner agent that a behaviour is now available.
	 */
	override void add(IBehaviour behaviour) {
		LOGGER.info("Try to add [{}]", behaviour)
		synchronized (behavioursLock) {
			readyBehaviours += behaviour
		}
		doNotify
	}

	override void run() {
		while (true) {
			var int size
			synchronized (behavioursLock) {
				size = readyBehaviours.size
				if (size > 0) {
					val behaviour = readyBehaviours.get(currentIndex)
					LOGGER.debug("Try to invoke action of [{}] behaviour", behaviour)
					currentIndex = (currentIndex + 1) % readyBehaviours.size()
					behaviour.action()
					if (behaviour.isDone) {
						removeFromReady(behaviour)
					}
				}
				size = readyBehaviours.size
			}
			if (size == 0) {
				doWait
			}
		}
	}

	/**
	 * Moves a behaviour from the ready queue to the sleeping queue. 
	 */
	override void block(IBehaviour behaviour) {
		LOGGER.info("Try to block [{}] Behaviour...", behaviour)
		synchronized (behavioursLock) {
			if (behaviour.removeFromReady) {
				blockedBehaviours += behaviour
			}
		}
	}

	override void blockAll() {
		LOGGER.info("Try to block all...")
		synchronized (behavioursLock) {
			blockedBehaviours += readyBehaviours
			readyBehaviours.clear
			currentIndex = 0
		}
	}

	/**
	 * Moves a behaviour from the sleeping queue to the ready queue.
	 */
	override void restart(IBehaviour behaviour) {
		LOGGER.info("Try to remove [{}] Behaviour...", behaviour)
		synchronized (behavioursLock) {
			if (behaviour.removeFromBlocked) {
				readyBehaviours += behaviour
			}
			doNotify
		}
	}

	/** 
	 * Restarts all behaviours. This method simply calls IBehaviour.restart() on
	 * every behaviour. The IBehaviour.restart() method then notifies the agent
	 * (with the Agent.notifyRestarted() method), causing Scheduler.restart() to
	 * be called (this also moves behaviours from the blocked queue to the ready
	 * queue --> we must copy all behaviours into a temporary buffer to avoid
	 * concurrent modification exceptions). Why not restarting only blocked
	 * behaviours? Some ready behaviour can be a ParallelIBehaviour with some of its
	 * children blocked. These children must be restarted too.
	 */
	override void restartAll() {
		LOGGER.info("Try to restart all...")
		synchronized (behavioursLock) {
			readyBehaviours += blockedBehaviours
			blockedBehaviours.clear
			currentIndex = 0
			doNotify
		}
	}

	/** 
	 * Removes a specified behaviour from the scheduler
	 */
	override void remove(IBehaviour behaviour) {
		LOGGER.info("Try to remove [{}] Behaviour...", behaviour)
		var found = removeFromBlocked(behaviour)
		if (!found) {
			found = removeFromReady(behaviour)
		}
	}

	/** 
	 * Removes a specified behaviour from the scheduler
	 */
	def void removeAll() {
		LOGGER.info("Try to remove all...")
		synchronized (behavioursLock) {
			readyBehaviours.clear
			blockedBehaviours.clear
			currentIndex = 0
		}
	}

	/**
	 *  Removes a specified behaviour from the blocked queue.
	 */
	def private boolean removeFromBlocked(IBehaviour behaviour) {
		LOGGER.info("Try to remove [{}] Behaviour from blocked...", behaviour)
		synchronized (behavioursLock) {
			return blockedBehaviours.remove(behaviour)
		}
	}

	/**
	 * Removes a specified behaviour from the ready queue.
	 * This can change the index of the current behaviour, so a check is
	 * made: if the just removed behaviour has an index lesser than the
	 * current one, then the current index must be decremented.
	 */
	def private boolean removeFromReady(IBehaviour behaviour) {
		LOGGER.info("Try to remove [{}] Behaviour from ready...", behaviour)
		var boolean result
		val index = readyBehaviours.indexOf(behaviour)
		LOGGER.debug("Scheduler removeFromReady size " + readyBehaviours.size)
		LOGGER.debug("Scheduler removeFromReady index " + index)
		LOGGER.debug("Scheduler removeFromReady currentIndex " + currentIndex)
		if (index != -1) {
			LOGGER.debug("Scheduler removeFromReady " + behaviour)
			result = readyBehaviours.remove(behaviour)
			LOGGER.debug("Scheduler removeFromReady result " + result)
			if (index < currentIndex) {
				currentIndex = currentIndex - 1
			} else if (index == currentIndex && currentIndex == readyBehaviours.size())
				currentIndex = 0
		}
		LOGGER.debug("Scheduler removeFromReady size " + readyBehaviours.size)
		LOGGER.debug("Scheduler removeFromReady index " + index)
		LOGGER.debug("Scheduler removeFromReady currentIndex " + currentIndex)
		return result
	}

	def private void doNotify() {
		synchronized (suspendLock) {
			LOGGER.info("Notify...")
			suspendLock.notify
		}
	}

	def private void doWait() {
		synchronized (suspendLock) {
			LOGGER.info("Begin waiting...")
			suspendLock.wait
		}
	}

}
