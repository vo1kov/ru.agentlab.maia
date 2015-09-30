package ru.agentlab.maia.execution.node.test.func

import ru.agentlab.maia.execution.scheduler.sequential.OneShotSequentialScheduler

class Test {

	def static void main(String[] args) {
		val parent = new OneShotSequentialScheduler
		val scheduler = new OneShotSequentialScheduler
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