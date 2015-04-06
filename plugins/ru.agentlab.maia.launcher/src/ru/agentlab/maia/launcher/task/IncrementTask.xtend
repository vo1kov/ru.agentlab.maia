package ru.agentlab.maia.launcher.task

import ru.agentlab.maia.Action
import ru.agentlab.maia.TaskOutput
import ru.agentlab.maia.TaskInput

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