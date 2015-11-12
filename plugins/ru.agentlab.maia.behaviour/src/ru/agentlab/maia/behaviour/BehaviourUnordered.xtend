package ru.agentlab.maia.behaviour

import java.util.HashSet

abstract class BehaviourUnordered extends BehaviourScheduler {

	val protected subtasks = new HashSet<IBehaviour>

	var protected IBehaviour current = null

	override getChilds() {
		return subtasks
	}

	override protected internalAddChild(IBehaviour task) {
		val added = subtasks += task
		if (added && task.first) {
			current = task
		}
		if (added && ready) {
			state = BehaviourState.READY
		}
		return added
	}

	override protected internalRemoveChild(IBehaviour task) {
		val removed = subtasks -= task
		if (removed && !ready) {
			state = BehaviourState.UNKNOWN
		}
		return removed
	}

	override protected internalClear() {
		subtasks.clear
		current = null
	}

	override protected internalExecute() {
		current.execute
	}

	def boolean isFirst(IBehaviour subtask)

	def boolean isReady()

}