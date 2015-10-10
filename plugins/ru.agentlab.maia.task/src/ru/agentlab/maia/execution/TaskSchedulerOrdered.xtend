package ru.agentlab.maia.execution

import java.util.ArrayList

/**
 * Task scheduler which selects tasks in order of adding.
 */
abstract class TaskSchedulerOrdered extends TaskScheduler {

	val protected subtasks = new ArrayList<ITask>

	var protected int index = 0

	override getSubtasks() {
		return subtasks
	}

	override protected internalAddSubtask(ITask task) {
		if (!subtasks.contains(task)) {
			subtasks += task
		} else {
			return false
		}
	}

	override protected internalRemoveSubtask(ITask task) {
		val i = subtasks.indexOf(task)
		if (i != -1) {
			subtasks.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i === index && index === subtasks.size()) {
				index = 0
			}
			return true
		} else {
			return false
		}
	}

	override protected internalClear() {
		subtasks.clear
		index = 0
	}

	override protected internalExecute() {
		if (subtasks.empty) {
			throw new IllegalStateException
		}
		subtasks.get(index).execute
	}

	/**
	 * Increment current index.
	 */
	override protected void internalSchedule() {
		index = index + 1
	}

	override restart() {
		super.restart()
		index = 0
	}

	override reset() {
		super.reset()
		index = 0
	}

}