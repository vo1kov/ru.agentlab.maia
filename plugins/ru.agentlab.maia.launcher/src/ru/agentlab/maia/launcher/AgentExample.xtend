package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.lifecycle.ILifecycleState

class AgentExample {

	val static LOGGER = LoggerFactory.getLogger(AgentExample)

	@Inject @Named(IContextFactory.KEY_NAME)
	String agentName

	@Inject
	IAgentId agentId

	@Inject
	extension IBehaviourFactory

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)
		createTicker("first", 1000) => [
			get(IContributionService).addContributor(BehaviourExample)
		]
//		createFromAnnotation("first2", BehaviourExample) => [
//			get(IContributionService).addContributor(BehaviourExample)
//		]
//		behaviourFactory.createTicker(context, "second", 1000) => [
//			addContributor(BehaviourExample)
//		]
		LOGGER.info("Agent ID: [{}] ", agentId.name)
	}

	@Inject @Optional
	def void onStateChange(ILifecycleState state) {
		LOGGER.info("State changed: [{}]", state)
	}
}