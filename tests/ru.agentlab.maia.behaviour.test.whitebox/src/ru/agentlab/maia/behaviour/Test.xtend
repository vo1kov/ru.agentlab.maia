package ru.agentlab.maia.behaviour

import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential

class Test {

	def static void main(String[] args) {
		val IBehaviourScheduler parent = new BehaviourSchedulerSequential
		val IBehaviourScheduler scheduler = new BehaviourSchedulerSequential
//		println("scheduler " + scheduler.stateName)
//		println("parent " + scheduler.stateName)
		parent.addChild(scheduler)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		val input = new Behaviour.Parameter("1", Object)
		val input2 = new Behaviour.Parameter("2", Object)
		scheduler.addInput(input)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		input.link(input2)
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
		scheduler.addInput(new Behaviour.Parameter("2", Object, true))
		println("scheduler " + scheduler.state)
		println("parent " + scheduler.state)
	}

}