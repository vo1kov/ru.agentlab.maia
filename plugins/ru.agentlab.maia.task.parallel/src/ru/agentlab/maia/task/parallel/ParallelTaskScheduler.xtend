package ru.agentlab.maia.task.parallel

import java.util.ArrayList
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.OrderedTaskScheduler
import ru.agentlab.maia.task.TaskState

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
class ParallelTaskScheduler extends OrderedTaskScheduler {

	val protected blockedSubtasks = new ArrayList<ITask>

	val protected terminatedSubtasks = new ArrayList<ITask>

	override getRetriesLimit() {
		return RETRIES_INFINITE
	}

	override notifySubtaskBlocked() {
		blockedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = TaskState.BLOCKED
		} else {
			state = TaskState.WORKING
		}
	}

	override notifySubtaskSuccess() {
		terminatedSubtasks += subtasks.remove(index)
		if (subtasks.empty) {
			state = TaskState.SUCCESS
		} else {
			state = TaskState.WORKING
		}
	}

	override notifySubtaskFailed() {
		state = TaskState.FAILED
	}

	override notifySubtaskWorking() {
		schedule()
	}

	override notifySubtaskReady(ITask task) {
		if (subtasks.contains(task)) {
			return
		}
		if (blockedSubtasks.remove(task) || terminatedSubtasks.remove(task)) {
			subtasks += task
			state = TaskState.READY
			return
		} else {
			throw new IllegalArgumentException("Subtask " + task + " doesn't contains in scheduler")
		}
	}

	override protected internalSchedule() {
		index = (index + 1) % subtasks.size
	}

}