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
package ru.agentlab.maia.scheduler.internal

import java.io.Serializable
import java.util.LinkedList
import java.util.List
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.scheduler.IScheduler

/** 
 * Name: Scheduler
 * Responsibility and Collaborations:
 * + Selects the behaviour to execute. (IBehaviour)
 * + Holds together all the behaviours of an agent. (Agent, IBehaviour)
 * + Manages the resources needed to synchronize and execute agent behaviours,
 * such as thread pools, locks, etc.
 */
class Scheduler implements Serializable, IScheduler {

	protected List<IBehaviour> readyBehaviours = new LinkedList<IBehaviour>

	protected List<IBehaviour> blockedBehaviours = new LinkedList<IBehaviour>

	private int currentIndex = 0

	/**
	 * Add a behaviour at the end of the behaviours queue.
	 * This can never change the index of the current behaviour.
	 * If the behaviours queue was empty notifies the embedded thread of
	 * the owner agent that a behaviour is now available.
	 */
	override synchronized void add(IBehaviour b) {
		readyBehaviours.add(b)
		notify()
	// owner.notifyAddIBehaviour(b)
	}

	/**
	 * Moves a behaviour from the ready queue to the sleeping queue. 
	 */
	override synchronized void block(IBehaviour b) {
		if (removeFromReady(b)) {
			blockedBehaviours.add(b)
//		 owner.notifyChangeIBehaviourState(b, IBehaviour.STATE_READY,
//			IBehaviour.STATE_BLOCKED
//			)
		}
	}

	/**
	 * Moves a behaviour from the sleeping queue to the ready queue.
	 */
	override synchronized void restart(IBehaviour b) {
		if (removeFromBlocked(b)) {
			readyBehaviours.add(b)
			notify()
//		 owner.notifyChangeIBehaviourState(b, IBehaviour.STATE_BLOCKED,
//		 IBehaviour.STATE_READY)
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
	override synchronized void restartAll() {
		blockedBehaviours.forEach[
			restart
		]
		
		//
		// IBehaviour[] behaviours = new IBehaviour[readyIBehaviours.size()]
		// int counter = 0
		// for (Iterator it = readyIBehaviours.iterator() it.hasNext())
		// behaviours[counter++] = (IBehaviour) it.next()
		// for (int i = 0 i < behaviours.length i++) {
		// IBehaviour b = behaviours[i]
		// b.restart()
		// }
		// behaviours = new IBehaviour[blockedIBehaviours.size()]
		// counter = 0
		// for (Iterator it = blockedIBehaviours.iterator() it.hasNext()) {
		// behaviours[counter++] = (IBehaviour) it.next()
		// }
		// for (int i = 0 i < behaviours.length i++) {
		// IBehaviour b = behaviours[i]
		// b.restart()
		// }
	}

	/** 
	 * Removes a specified behaviour from the scheduler
	 */
	override synchronized void remove(IBehaviour b) {
		var found = removeFromBlocked(b)
		if (!found) {
			found = removeFromReady(b)
		}
		if (found) {
//			owner.notifyRemoveIBehaviour(b)
		}
	}

	/** 
	 * Selects the appropriate behaviour for execution, with a trivial
	 * round-robin algorithm.
	 */
	override synchronized IBehaviour schedule() throws InterruptedException {
		while (readyBehaviours.isEmpty()) {
//		 owner.idle()
		}
		val IBehaviour b = readyBehaviours.get(currentIndex)
		currentIndex = (currentIndex + 1) % readyBehaviours.size()
		return b
	}

	// Helper method for persistence service
	override synchronized IBehaviour[] getBehaviours() {
		return readyBehaviours + blockedBehaviours
	}

	/**
	 * Helper method for persistence service
	 */
	override void setBehaviours(IBehaviour[] behaviours) {
		// readyIBehaviours.clear()
		// blockedIBehaviours.clear()
		// for (int i = 0 i < behaviours.length i++) {
		// IBehaviour b = behaviours[i]
		// if (b.isRunnable()) {
		// readyIBehaviours.add(b)
		// } else {
		// blockedIBehaviours.add(b)
		// }
		// }
		//
		// // The current index is not saved when persisting an agent
		// currentIndex = 0
	}

	/**
	 *  Removes a specified behaviour from the blocked queue.
	 */
	def private boolean removeFromBlocked(IBehaviour b) {
		return blockedBehaviours.remove(b)
	}

	/**
	 * Removes a specified behaviour from the ready queue.
	 * This can change the index of the current behaviour, so a check is
	 * made: if the just removed behaviour has an index lesser than the
	 * current one, then the current index must be decremented.
	 */
	def private boolean removeFromReady(IBehaviour b) {
		val index = readyBehaviours.indexOf(b)
		if (index != -1) {
			readyBehaviours.remove(b)
			if (index < currentIndex) {
				currentIndex = currentIndex - 1
			} else if (index == currentIndex && currentIndex == readyBehaviours.size())
				currentIndex = 0
		}
		return index != -1
	}

}
