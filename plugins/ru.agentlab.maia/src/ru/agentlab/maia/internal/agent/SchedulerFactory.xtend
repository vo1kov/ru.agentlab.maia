package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory

class SchedulerFactory implements ISchedulerFactory {
	
	override IScheduler get() {
		return new Scheduler()
	}

}
