package ru.agentlab.maia.task.issue

import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.behaviour.IBehaviour

class SetTaskIssue extends Issue {

	val Class<? extends IBehaviour> type

	new(String target, String result, Class<? extends IBehaviour> type) {
		super(target, result)
		this.type = type
	}
	
	override resolve(Object target) {
		var task = target
		if (task == null || !type.isAssignableFrom(task.class)) {
			task = type.newInstance
			return task
		} else {
			return null
		}
	}

}