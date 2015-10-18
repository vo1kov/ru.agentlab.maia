package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import ru.agentlab.maia.task.ITaskScheduler

class TaskSchedulerStorage implements Provider<ITaskScheduler> {

	var ITaskScheduler scheduler

	override get() {
		return scheduler
	}

	def void set(ITaskScheduler scheduler) {
		this.scheduler = scheduler
	}

}