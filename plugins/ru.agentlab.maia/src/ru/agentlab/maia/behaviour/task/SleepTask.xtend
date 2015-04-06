package ru.agentlab.maia.behaviour.task

import javax.inject.Inject
import ru.agentlab.maia.Action
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour

class SleepTask {

	@Inject
	IScheduler scheduler

	@Inject
	IBehaviour behaviour

	@Action
	def void action() {
		scheduler.block(behaviour)
	}

}