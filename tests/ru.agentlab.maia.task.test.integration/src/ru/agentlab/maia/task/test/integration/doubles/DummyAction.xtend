package ru.agentlab.maia.task.test.integration.doubles

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.annotation.Execute

class DummyAction {

	@Accessors(PUBLIC_GETTER)
	var protected int count = 0

	@Execute
	def void action() {
		count++
	}

}