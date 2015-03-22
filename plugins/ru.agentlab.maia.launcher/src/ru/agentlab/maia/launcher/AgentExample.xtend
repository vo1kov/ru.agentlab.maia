package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentId

class AgentExample {

	val static LOGGER = LoggerFactory.getLogger(AgentExample)

	@Inject @Named(IAgent.KEY_NAME)
	String agentName

	@Inject
	IAgent agent
	
	@Inject
	IAgentId agentId

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)
		agent.addBehaviour("first", BehaviourExample)
		agent.addBehaviour("second", BehaviourExample2)
		LOGGER.info("Agent ID: [{}] ", agentId.name)
	}

	@Inject
	def void onStateChange(@Named(IAgent.KEY_STATE) String state) {
		LOGGER.info("State changed: [{}]", state)
	}
}