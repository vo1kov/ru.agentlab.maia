package ru.agentlab.maia.behaviour.scheme.task.lib

import ru.agentlab.maia.execution.action.annotation.Action

class SleepTask {

//	@Inject
//	IMaiaExecutorScheduler scheduler
//
//	@Inject
//	IMaiaExecutorScheduler behaviour

	@Action
	def void action() {
//		scheduler.block(behaviour)
	}

}