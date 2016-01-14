package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector

class MaiaContainerContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => [
			put(IContext.KEY_TYPE, "container")
			get(IInjector) => [
				deploy(BehaviourSchedulerSequential, IBehaviour)
//				deploy(BehaviourExecutor, IBehaviourExecutor)
			]
		]
	}
}
