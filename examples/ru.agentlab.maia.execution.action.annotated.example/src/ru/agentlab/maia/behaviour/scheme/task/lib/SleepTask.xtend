package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.execution.scheduler.IMaiaContextScheduler

class SleepTask {

	@Inject
	IMaiaContextScheduler scheduler

	@Inject
	IMaiaContextScheduler behaviour

	@Action
	def void action() {
//		scheduler.block(behaviour)
	}

}