package ru.agentlab.maia.execution.node.test.func

import ru.agentlab.maia.execution.ExecutionParameter
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

class Test {

	def static void main(String[] args) {
		val ITaskScheduler parent = new SequentialTaskScheduler
		val ITaskScheduler scheduler = new SequentialTaskScheduler
//		println("scheduler " + scheduler.stateName)
//		println("parent " + scheduler.stateName)
		parent.addSubtask(scheduler)
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