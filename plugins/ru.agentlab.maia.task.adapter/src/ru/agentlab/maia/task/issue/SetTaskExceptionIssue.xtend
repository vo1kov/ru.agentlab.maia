package ru.agentlab.maia.task.issue

import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.TaskException

class SetTaskExceptionIssue extends Issue {
	
	val String label

	new(String target, String result, String label) {
		super(target, result)
		this.label = label
	}

	override resolve(Object target) {
		val task = target as ITask
		var exception = task.exceptions.findFirst[it.name == name]
		if (exception == null) {
			exception = new TaskException(label)
		}
		return exception
	}
	
}