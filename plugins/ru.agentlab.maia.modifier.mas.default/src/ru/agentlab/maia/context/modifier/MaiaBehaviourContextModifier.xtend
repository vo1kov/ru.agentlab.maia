package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaServiceDeployer

class MaiaBehaviourContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			set(IMaiaContext.KEY_TYPE, "behaviour")
			get(IMaiaServiceDeployer) => [
				deploy(SequenceContextScheduler, IExecutionNode)
			]
		]
	}
}