package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import org.maia.task.Action
import ru.agentlab.maia.execution.scheduler.IScheduler

class SleepTask {

	@Inject
	IScheduler scheduler

	@Inject
	IScheduler behaviour

	@Action
	def void action() {
//		scheduler.block(behaviour)
	}

}