package ru.agentlab.maia.execution

import java.util.HashSet

abstract class TaskSchedulerUnordered extends TaskScheduler {

	val protected subtasks = new HashSet<ITask>

	var protected ITask current = null

	override getSubtasks() {
		return subtasks
	}

	override protected internalAddSubtask(ITask task) {
		val added = subtasks += task
		if (added && task.first) {
			current = task
		}
		if (added && ready) {
			state = State.READY
		}
		return added
	}

	override protected internalRemoveSubtask(ITask task) {
		val removed = subtasks -= task
		if (removed && !ready) {
			state = State.UNKNOWN
		}
		return removed
	}

	override protected internalClear() {
		subtasks.clear
		current = null
	}

	override protected internalRun() {
		current.run
	}

	def boolean isFirst(ITask subtask)

	def boolean isReady()

}