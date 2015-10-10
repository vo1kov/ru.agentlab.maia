package ru.agentlab.maia.task.sequential

import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.OrderedTaskScheduler

/**
 * <p>
 * Sequential implementation of {@link IExecutionScheduler}.
 * Select child nodes in order of adding.
 * <p>Default policies:</p><ul>
 * <li>When any child become {@link State#BLOCKED BLOCKED} then 
 * scheduler become {@link State#BLOCKED BLOCKED};</li>
 * <li>When any child become {@link State#FAILED FAILED} then 
 * scheduler become {@link State#FAILED FAILED};</li>
 * <li>When any child become  {@link State#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link State#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class SequentialTaskScheduler extends OrderedTaskScheduler {

	override notifySubtaskBlocked() {
		state = State.BLOCKED
	}

	override notifySubtaskSuccess() {
		if (index < subtasks.size - 1) {
			schedule()
		} else {
			state = State.SUCCESS
		}
	}

	override notifySubtaskFailed() {
		state = State.FAILED
	}

	override notifySubtaskWorking() {
		idle()
	}

	override notifySubtaskReady(ITask node) {
		if (node !== subtasks.get(index)) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		state = State.READY
	}

}