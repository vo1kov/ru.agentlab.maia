package ru.agentlab.maia.internal.agent

import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory

class SchedulerFactory implements ISchedulerFactory {

	override IScheduler create(String name) {
		return new Scheduler(name)
	}

}
