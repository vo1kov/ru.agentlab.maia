package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.behaviour.BehaviourExecutor
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourExecutor
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential

class MaiaContainerContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => [
			putService(IContext.KEY_TYPE, "container")
			getService(IInjector) => [
				deploy(BehaviourSchedulerSequential, IBehaviour)
				deploy(BehaviourExecutor, IBehaviourExecutor)
			]
		]
	}
}