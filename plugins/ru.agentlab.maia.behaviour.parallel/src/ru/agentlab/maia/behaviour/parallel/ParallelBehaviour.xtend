package ru.agentlab.maia.behaviour.parallel

import java.util.ArrayList
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourState
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

import static ru.agentlab.maia.behaviour.BehaviourState.*

/**
 * <p>Parallel implementation of {@link ITaskScheduler}.
 * Execute until all nodes are performed.  
 * Select child nodes in order of adding.</p>
 * 
 * <p>Default policies:</p>
 * 
 * <ul>
 * <li>When any child become {@link TaskState#BLOCKED BLOCKED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link TaskState#FAILED FAILED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link TaskState#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link TaskState#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class ParallelBehaviour extends Behaviour implements IBehaviourScheduler {

	val protected childs = new ArrayList<Behaviour>

	val protected blockedSubtasks = new ArrayList<IBehaviour>

	val protected terminatedSubtasks = new ArrayList<IBehaviour>

	var protected int index = 0

////	override getRetriesLimit() {
////		return RETRIES_INFINITE
////	}
//	override notifyChildBlocked() {
//		blockedSubtasks += childs.remove(index)
//		if (childs.empty) {
//			state = BehaviourState.BLOCKED
//		} else {
//			state = BehaviourState.WORKING
//		}
//	}
//
//	override notifyChildSuccess() {
//		terminatedSubtasks += childs.remove(index)
//		if (childs.empty) {
//			state = BehaviourState.SUCCESS
//		} else {
//			state = BehaviourState.WORKING
//		}
//	}
//
////	override notifyChildFailed() {
////		state = BehaviourState.FAILED
////	}
//	override notifyChildWorking() {
//		schedule()
//		state = BehaviourState.WORKING
//	}
//
//	override notifyChildReady(IBehaviour task) {
//		if (childs.contains(task)) {
//			return
//		}
//		if (blockedSubtasks.remove(task) || terminatedSubtasks.remove(task)) {
//			childs += task
//			state = BehaviourState.READY
//			return
//		} else {
//			throw new IllegalArgumentException("Subtask " + task + " doesn't contains in scheduler")
//		}
//	}
	override getChilds() {
		return childs
	}

	override addChild(Behaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!childs.contains(child)) {
			childs.add(child)
			if (state == UNKNOWN) {
				state = READY
			}
			return true
		} else {
			return false
		}
	}

	override removeChild(Behaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(child)
		if (i != -1) {
			childs.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i === index && index === childs.size()) {
				index = 0
			}
			if (childs.empty) {
				state = UNKNOWN
			}
			return true
		} else {
			return false
		}
	}

	override clear() {
		childs.clear
		index = 0
		state = UNKNOWN
	}

	override execute() throws Exception {
		val current = childs.get(index)
		try {
			current.execute
			switch (current.state) {
				case SUCCESS: {
					terminatedSubtasks += childs.remove(index)
					if (childs.empty) {
						state = BehaviourState.SUCCESS
					} else {
						state = BehaviourState.WORKING
					}
				}
				case WORKING: {
					schedule()
					state = BehaviourState.WORKING
				}
				case BLOCKED: {
					blockedSubtasks += childs.remove(index)
					if (childs.empty) {
						state = BehaviourState.BLOCKED
					} else {
						state = BehaviourState.WORKING
					}
				}
				default: {
					state = current.state
				}
			}
		} catch (Exception e) {
			state = FAILED
			throw e
		}
	}

	def private schedule() {
		index = (index + 1) % childs.size
	}

}