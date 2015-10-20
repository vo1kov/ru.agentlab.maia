package ru.agentlab.maia.task.test.integration.doubles

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.task.annotation.Action

class DummyAction {

	@Accessors(PUBLIC_GETTER)
	var protected int count = 0

	@Action
	def void action() {
		count++
	}

}