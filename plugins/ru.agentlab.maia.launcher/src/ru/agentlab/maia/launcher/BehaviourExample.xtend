package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.behaviour.IBehaviour

class BehaviourExample {

	@Inject @Named(IAgent.KEY_NAME)
	String agentName

	@Inject @Named(IBehaviour.KEY_NAME)
	String behaviourName

	@PostConstruct
	def void setup2() {
		println("BEHAVIOUR_EXAMPLE setup behaviour")
		println("BEHAVIOUR_EXAMPLE agentName " + agentName)
		println("BEHAVIOUR_EXAMPLE behaviourName " + behaviourName)

	}

}