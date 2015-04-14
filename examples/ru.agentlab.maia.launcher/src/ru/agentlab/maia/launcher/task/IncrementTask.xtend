package ru.agentlab.maia.launcher.task

import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.execution.action.annotated.TaskInput
import ru.agentlab.maia.execution.action.annotated.TaskOutput

class IncrementTask {

	@TaskInput
	public int i

	@TaskOutput
	public int i2

	@Action
	def void action() {
		i2 = i + 1
		println("	" + this + "::i = " + i)
		println("	" + this + "::i2 = " + i2)
	}

}