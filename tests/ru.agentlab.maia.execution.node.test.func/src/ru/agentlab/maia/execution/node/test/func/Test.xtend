package ru.agentlab.maia.execution.node.test.func

import ru.agentlab.maia.execution.scheduler.sequential.SequentialScheduler
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.execution.ExecutionParameter

class Test {

	def static void main(String[] args) {
		val IExecutionScheduler parent = new SequentialScheduler
		val IExecutionScheduler scheduler = new SequentialScheduler
//		println("scheduler " + scheduler.stateName)
//		println("parent " + scheduler.stateName)
		parent.addChild(scheduler)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		val input = new ExecutionParameter("1", Object)
		val input2 = new ExecutionParameter("2", Object)
		scheduler.addInput(input)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		input.link(input2)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		scheduler.addInput(new ExecutionParameter("2", Object, true))
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
	}

}