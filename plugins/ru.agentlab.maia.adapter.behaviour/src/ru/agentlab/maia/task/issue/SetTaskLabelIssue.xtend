package ru.agentlab.maia.task.issue

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.adapter.Issue
import ru.agentlab.maia.behaviour.IBehaviour

@Accessors
class SetTaskLabelIssue extends Issue {

	val String label

	new(String target, String result, String label) {
		super(target, result)
		this.label = label
	}

	override resolve(Object target) {
		val task = target as IBehaviour
		if (task.label != label) {
			task.label = label
		}
		return null
	}

}