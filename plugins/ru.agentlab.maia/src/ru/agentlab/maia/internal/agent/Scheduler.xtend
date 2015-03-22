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
		start
	}

	/**
	 * Add a behaviour at the end of the behaviours queue.
	 * This can never change the index of the current behaviour.
	 * If the behaviours queue was empty notifies the embedded thread of
	 * the owner agent that a behaviour is now available.
	 */
	override void add(IBehaviour action) {
		println("Scheduler add " + action)
		synchronized (behavioursLock) {
			readyBehaviours += action
		}
		synchronized (suspendLock) {
			suspendLock.notify
		}
	}

	override void run() {
		while (true) {
			var int size
			synchronized (behavioursLock) {
				size = readyBehaviours.size
				if (size > 0) {
					val behhaviour = schedule
					behhaviour.action()
					if (behhaviour.isDone) {
						removeFromReady(behhaviour)
					}
				}
				size = readyBehaviours.size
			}
			if (size == 0) {
				println("Scheduler wait")
				synchronized (suspendLock) {
					suspendLock.wait
				}
			}
		}
	}

	/**
	 * Moves a behaviour from the ready queue to the sleeping queue. 
	 */
	override void block(IBehaviour b) {
		synchronized (behavioursLock) {
			if (b.removeFromReady) {
				blockedBehaviours += b
			}
		}
	}

	override void blockAll() {
		println("Scheduler block all")
		synchronized (behavioursLock) {
			blockedBehaviours += readyBehaviours
			readyBehaviours.clear
			currentIndex = 0
		}
	}

	/**
	 * Moves a behaviour from the sleeping queue to the ready queue.
	 */
	override void restart(IBehaviour b) {
		synchronized (behavioursLock) {
			if (b.removeFromBlocked) {
				readyBehaviours += b
			}
			synchronized (suspendLock) {
				suspendLock.notify
			}
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
		println("RESTART ALL")
		synchronized (behavioursLock) {
			readyBehaviours += blockedBehaviours
			blockedBehaviours.clear
			currentIndex = 0
			synchronized (suspendLock) {
				suspendLock.notify
			}
		}
	}

	/** 
	 * Removes a specified behaviour from the scheduler
	 */
	override void remove(IBehaviour b) {
		println("REMOVE " + b)
		var found = removeFromBlocked(b)
		if (!found) {
			found = removeFromReady(b)
		}
		if (found) {
		}
	}

	/** 
	 * Selects the appropriate behaviour for execution, with a trivial
	 * round-robin algorithm.
	 */
	override IBehaviour schedule() throws InterruptedException {
		if (!readyBehaviours.empty) {
			val IBehaviour b = readyBehaviours.get(currentIndex)
			currentIndex = (currentIndex + 1) % readyBehaviours.size()
			return b
		}
	}

	// Helper method for persistence service
	override IBehaviour[] getBehaviours() {
		return readyBehaviours + blockedBehaviours
	}

	/**
	 *  Removes a specified behaviour from the blocked queue.
	 */
	def private boolean removeFromBlocked(IBehaviour b) {
		synchronized (behavioursLock) {
			return blockedBehaviours.remove(b)
		}
	}

	/**
	 * Removes a specified behaviour from the ready queue.
	 * This can change the index of the current behaviour, so a check is
	 * made: if the just removed behaviour has an index lesser than the
	 * current one, then the current index must be decremented.
	 */
	def private boolean removeFromReady(IBehaviour b) {
		var boolean result
		val index = readyBehaviours.indexOf(b)
		println("Scheduler removeFromReady size " + readyBehaviours.size)
		println("Scheduler removeFromReady index " + index)
		println("Scheduler removeFromReady currentIndex " + currentIndex)
		if (index != -1) {
			println("Scheduler removeFromReady " + b)
			result = readyBehaviours.remove(b)
			println("Scheduler removeFromReady result " + result)
			if (index < currentIndex) {
				currentIndex = currentIndex - 1
			} else if (index == currentIndex && currentIndex == readyBehaviours.size())
				currentIndex = 0
		}
		println("Scheduler removeFromReady size " + readyBehaviours.size)
		println("Scheduler removeFromReady index " + index)
		println("Scheduler removeFromReady currentIndex " + currentIndex)
		return result
	}

}
