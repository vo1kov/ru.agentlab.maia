package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.sequential.SequentialBehaviour
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector

class MaiaBehaviourContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => [
			putService(IContext.KEY_TYPE, "behaviour")
			getService(IInjector) => [
				deploy(SequentialBehaviour, IBehaviour)
			]
		]
	}
}