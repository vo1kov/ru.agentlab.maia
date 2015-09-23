package ru.agentlab.maia.execution.node.test.func

import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.node.ExecutionInput

class Test {
	
	def static void main(String[] args) {
		val scheduler = new SequenceContextScheduler
		println(scheduler.stateName)
		val input = new ExecutionInput("1", Object, scheduler, false)
		val input2 = new ExecutionInput("2", Object, scheduler, false)
		scheduler.addInput(input)
		println(scheduler.stateName)
		input.connect(input2)
		println(scheduler.stateName)
		scheduler.addInput(new ExecutionInput("2", Object, scheduler, true))
		println(scheduler.stateName)
	}
	
}