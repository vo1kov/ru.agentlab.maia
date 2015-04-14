package ru.agentlab.maia.launcher.task

import org.maia.task.Action
import org.maia.task.TaskInput
import org.maia.task.TaskOutput

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