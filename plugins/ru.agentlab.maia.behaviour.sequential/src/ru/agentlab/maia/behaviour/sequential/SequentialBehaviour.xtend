package ru.agentlab.maia.behaviour.sequential

import ru.agentlab.maia.behaviour.BehaviourOrdered
import ru.agentlab.maia.behaviour.IBehaviourScheduler

/**
 * <p>Sequential implementation of {@link IBehaviourScheduler}.
 * Select child nodes in order of adding.</p>
 * 
 * <p>Default policies:</p>
 * 
 * <ul>
 * <li>When any child become {@link TaskState#BLOCKED BLOCKED} then 
 * scheduler become {@link TaskState#BLOCKED BLOCKED};</li>
 * <li>When any child become {@link TaskState#FAILED FAILED} then 
 * scheduler become {@link TaskState#FAILED FAILED};</li>
 * <li>When any child become  {@link TaskState#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link TaskState#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author Shishkin Dmitriy
 */
class SequentialBehaviour extends BehaviourOrdered {
	
//	override notifyChildBlocked() {
//		state = BehaviourState.BLOCKED
//	}
//	override notifyChildSuccess() {
//		if (index < subtasks.size - 1) {
//			schedule()
//		} else {
//			state = BehaviourState.SUCCESS
//		}
//	}
//	
//	override protected isLastChild() {
//		return index < subtasks.size - 1
//	}
//	
//	override protected schedule() {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
//	}
//	override notifyChildFailed() {
//		state = BehaviourState.FAILED
//	}
//
//	override notifyChildWorking() {
//		state = BehaviourState.WORKING
//	}
//
//	override notifyChildReady(IBehaviour node) {
//		if (!subtasks.contains(node)) {
//			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
//		}
//		state = BehaviourState.READY
//	}
}
