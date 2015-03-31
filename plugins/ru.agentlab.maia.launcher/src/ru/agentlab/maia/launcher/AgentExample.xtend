package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeCyclic
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMappingFactory
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.launcher.task.DumpAgentNameTask
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
		createDefault("first") => [
			get(IContributionService).addContributor(BehaviourExample)
		]
		createDefault("second") => [ beh |
			val scheme = ContextInjectionFactory.make(BehaviourSchemeCyclic, beh)
			ContextInjectionFactory.invoke(scheme, PostConstruct, beh, null)
			beh.modify(IBehaviourScheme, scheme)
			val mapping = beh.get(IBehaviourTaskMappingFactory).create => [
				val task = ContextInjectionFactory.make(DumpAgentNameTask, beh)
				put(BehaviourSchemeCyclic.STATE_MAIN, task)
			]
			beh.modify(IBehaviourTaskMapping, mapping)
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