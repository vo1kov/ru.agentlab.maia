package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.IMaiaExecutorTask
import ru.agentlab.maia.execution.MaiaExecutorTask
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

class MaiaContainerContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			set(IMaiaContext.KEY_TYPE, "container")
			get(IMaiaServiceDeployer) => [
				deploy(SequenceContextScheduler, IMaiaExecutorScheduler)
				deploy(MaiaExecutorTask, IMaiaExecutorTask)
			]
		]
	}
}