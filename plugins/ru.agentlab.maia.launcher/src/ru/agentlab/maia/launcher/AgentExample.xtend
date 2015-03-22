package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgent

class AgentExample {

	val static LOGGER = LoggerFactory.getLogger(AgentExample)

	@Inject @Named(IAgent.KEY_NAME)
	String agentName

	@Inject
	IAgent agent

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)
		agent.addBehaviour("first", BehaviourExample)
		agent.addBehaviour("second", BehaviourExample2)
	}

	@Inject
	def void onStateChange(@Named(IAgent.KEY_STATE) String state) {
		LOGGER.info("State changed: [{}]", state)
	}
}