package ru.agentlab.maia.task.issue

import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourException

class SetTaskExceptionIssue extends Issue {
	
	val String label

	new(String target, String result, String label) {
		super(target, result)
		this.label = label
	}

	override resolve(Object target) {
		val task = target as IBehaviour
		var exception = task.exceptions.findFirst[it.name == name]
		if (exception == null) {
			exception = new BehaviourException(label)
		}
		return exception
	}
	
}