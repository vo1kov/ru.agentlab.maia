package ru.agentlab.maia.task.issue

import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.TaskParameter

class SetTaskInputIssue extends Issue {

	val String name

	val Class<?> type

	new(String target, String result, String name, Class<?> type) {
		super(target, result)
		this.name = name
		this.type = type

	}

	override resolve(Object target) {
		val task = target as ITask
		var parameter = task.inputs.findFirst[it.name == name]
		if (parameter == null) {
			parameter = new TaskParameter(name, type)
		}
		return parameter
	}

}