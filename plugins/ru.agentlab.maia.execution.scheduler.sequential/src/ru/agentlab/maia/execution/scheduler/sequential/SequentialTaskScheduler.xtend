package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITask.State
import ru.agentlab.maia.execution.TaskSchedulerOrdered

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
class SequentialTaskScheduler extends TaskSchedulerOrdered {

	override notifySubtaskBlocked() {
		setStateBlocked()
	}

	override notifySubtaskSuccess() {
		if (index < subtasks.size) {
			schedule()
		} else {
			setStateSuccess()
		}
	}

	override notifySubtaskFailed() {
		setStateFailed()
	}

	override notifySubtaskWorking() {
		idle()
	}

	override notifySubtaskReady(ITask node) {
		if (node !== subtasks.get(index)) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		setStateReady()
	}

}