package ru.agentlab.maia.task.issue

import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourParameter

class SetTaskInputIssue extends Issue {

	val String name

	val Class<?> type

	new(String target, String result, String name, Class<?> type) {
		super(target, result)
		this.name = name
		this.type = type

	}

	override resolve(Object target) {
		val task = target as IBehaviour
		var parameter = task.inputs.findFirst[it.name == name]
		if (parameter == null) {
			parameter = new BehaviourParameter(name, type)
		}
		return parameter
	}

}