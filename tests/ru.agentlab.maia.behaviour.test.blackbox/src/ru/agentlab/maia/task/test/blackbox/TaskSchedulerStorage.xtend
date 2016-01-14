package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import ru.agentlab.maia.IBehaviourScheduler

class TaskSchedulerStorage implements Provider<IBehaviourScheduler> {

	var IBehaviourScheduler scheduler

	override get() {
		return scheduler
	}

	def void set(IBehaviourScheduler scheduler) {
		this.scheduler = scheduler
	}

}