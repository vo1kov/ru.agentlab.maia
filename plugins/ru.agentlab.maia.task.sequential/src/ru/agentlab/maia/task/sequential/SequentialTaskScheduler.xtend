package ru.agentlab.maia.task.sequential

import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.TaskState
import ru.agentlab.maia.task.TaskSchedulerOrdered

/**
 * <p>
 * Sequential implementation of {@link IExecutionScheduler}.
 * Select child nodes in order of adding.
 * <p>Default policies:</p><ul>
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
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class SequentialTaskScheduler extends TaskSchedulerOrdered {

	new() {
		super()
	}

	new(String uuid) {
		super(uuid)
	}

	override notifySubtaskBlocked() {
		state = TaskState.BLOCKED
	}

	override notifySubtaskSuccess() {
		if (index < subtasks.size - 1) {
			schedule()
		} else {
			state = TaskState.SUCCESS
		}
	}

	override notifySubtaskFailed() {
		state = TaskState.FAILED
	}

	override notifySubtaskWorking() {
		idle()
	}

	override notifySubtaskReady(ITask node) {
		if (!subtasks.contains(node)) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		state = TaskState.READY
	}

}