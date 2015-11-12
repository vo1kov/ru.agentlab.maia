package ru.agentlab.maia.task.test.integration.doubles

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.annotation.Action
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output

class DummyParametrizedAction {

	@Accessors(PUBLIC_GETTER)
	var int count = 0

	@Input
	var Object input

	@Output
	var Object output

	@Action
	def void action() {
		count++
		output = input
	}

}