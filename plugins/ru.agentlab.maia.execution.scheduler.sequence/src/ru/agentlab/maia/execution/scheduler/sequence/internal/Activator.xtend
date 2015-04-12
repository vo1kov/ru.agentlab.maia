package ru.agentlab.maia.execution.scheduler.sequence.internal

import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextSchedulerFactory
import ru.agentlab.maia.profile.MaiaProfile
import ru.agentlab.maia.execution.scheduler.ISchedulerFactory

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile() => [
			put(ISchedulerFactory, SequenceContextSchedulerFactory)
		]
	}

}
