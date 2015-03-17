package ru.agentlab.maia.scheduler.internal

import ru.agentlab.maia.scheduler.IScheduler
import ru.agentlab.maia.scheduler.ISchedulerProvider

class SchedulerProvider implements ISchedulerProvider {
	override IScheduler get() {
		return new Scheduler()
	}

}
