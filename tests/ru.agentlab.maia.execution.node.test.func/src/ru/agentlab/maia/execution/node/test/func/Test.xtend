package ru.agentlab.maia.execution.node.test.func

import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.node.ExecutionInput

class Test {
	
	def static void main(String[] args) {
		val parent = new SequenceContextScheduler
		val scheduler = new SequenceContextScheduler
		println("scheduler " + scheduler.stateName)
		println("parent " + scheduler.stateName)
		parent.addChild(scheduler)
		println("scheduler " + scheduler.stateName)
		println("parent " + scheduler.stateName)
		val input = new ExecutionInput("1", Object, scheduler)
		val input2 = new ExecutionInput("2", Object, scheduler)
		scheduler.addInput(input)
		println("scheduler " + scheduler.stateName)
		println("parent " + scheduler.stateName)
		input.link(input2)
		println("scheduler " + scheduler.stateName)
		println("parent " + scheduler.stateName)
		scheduler.addInput(new ExecutionInput("2", Object, scheduler, true))
		println("scheduler " + scheduler.stateName)
		println("parent " + scheduler.stateName)
	}
	
}