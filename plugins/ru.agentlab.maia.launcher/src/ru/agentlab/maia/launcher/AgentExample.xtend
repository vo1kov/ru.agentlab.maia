package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
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

	@Inject
	IEclipseContext context

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)
		agent.addBehaviour("first", BehaviourExample)
		agent.addBehaviour("second", BehaviourExample2)
		LOGGER.info("Agent ID: [{}] ", agentId.name)
		LOGGER.info("Agent context: [{}]", context)
		(context as EclipseContext).localData.forEach[p1, p2|
			LOGGER.info("Context Data: [{}] -> [{}]", p1, p2)
		]
	}

	@Inject
	def void onStateChange(@Named(IAgent.KEY_STATE) String state) {
		LOGGER.info("State changed: [{}]", state)
	}
}