package ru.agentlab.maia.behaviour.parallel

import java.util.ArrayList
import ru.agentlab.maia.behaviour.BehaviourState
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourOrdered

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
class ParallelBehaviour extends BehaviourOrdered {

	val protected blockedSubtasks = new ArrayList<IBehaviour>

	val protected terminatedSubtasks = new ArrayList<IBehaviour>

	override getRetriesLimit() {
		return RETRIES_INFINITE
	}

	override notifyChildBlocked() {
		blockedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = BehaviourState.BLOCKED
		} else {
			state = BehaviourState.WORKING
		}
	}

	override notifyChildSuccess() {
		terminatedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = BehaviourState.SUCCESS
		} else {
			state = BehaviourState.WORKING
		}
	}

	override notifyChildFailed() {
		state = BehaviourState.FAILED
	}

	override notifyChildWorking() {
		schedule()
	}

	override notifyChildReady(IBehaviour task) {
		if (subtasks.contains(task)) {
			return
		}
		if (blockedSubtasks.remove(task) || terminatedSubtasks.remove(task)) {
			subtasks += task
			state = BehaviourState.READY
			return
		} else {
			throw new IllegalArgumentException("Subtask " + task + " doesn't contains in scheduler")
		}
	}

	override protected internalSchedule() {
		index = (index + 1) % subtasks.size
	}

}