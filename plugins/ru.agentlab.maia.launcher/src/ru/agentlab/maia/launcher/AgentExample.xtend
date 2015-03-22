package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.agent.IAgent

class AgentExample {

	@Inject @Named(IAgent.KEY_NAME)
	String agentName

	@Inject
	IAgent agent

	@PostConstruct
	def void setup() {
		println("AGENT_EXAMPLE setup of: [" + agentName + "] agent")
		agent.addBehaviour("first", BehaviourExample)
		agent.addBehaviour("second", BehaviourExample2)
	}

	@Inject
	def void onStateChange(@Named(IAgent.KEY_STATE) String state) {
		println("AGENT_EXAMPLE state changed: " + state)
	}
}