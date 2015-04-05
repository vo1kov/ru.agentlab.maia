package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMappingFactory
import ru.agentlab.maia.context.IContextFactory
import ru.agentlab.maia.initializer.IInitializerService
import ru.agentlab.maia.internal.behaviour.scheme.impl.BehaviourSchemeCyclic
import ru.agentlab.maia.internal.behaviour.scheme.impl.BehaviourSchemeOneShot
import ru.agentlab.maia.launcher.task.DumpAgentNameTask
import ru.agentlab.maia.launcher.task.SendTestMessageTask
import ru.agentlab.maia.lifecycle.scheme.ILifecycleState

class AgentExample {

	val static LOGGER = LoggerFactory.getLogger(AgentExample)

	@Inject @Named(IContextFactory.KEY_NAME)
	String agentName

	@Inject
	IAgentId agentId

	@Inject
	extension IBehaviourFactory

	@Inject
	BehaviourSchemeOneShot oneShotScheme

	@Inject
	BehaviourSchemeCyclic cyclicScheme

	@PostConstruct
	def void setup() {
		LOGGER.info("Setup of: [{}] agent", agentName)
		createDefault("first") => [
			get(IInitializerService).addInitializer(BehaviourExample)
		]
		createDefault("second") => [ beh |
			beh.modify(IBehaviourScheme, oneShotScheme)
			val mapping = beh.get(IBehaviourTaskMappingFactory).create => [
				val task = ContextInjectionFactory.make(DumpAgentNameTask, beh)
				put(BehaviourSchemeOneShot.STATE_MAIN, task)
			]
			beh.modify(IBehaviourTaskMapping, mapping)
		]
		val port = Integer.parseInt(System.getProperty("port", "8899"))
		if (port == 8888) {
			createDefault("send") => [ beh |
				beh.modify(IBehaviourScheme, oneShotScheme)
				val mapping = beh.get(IBehaviourTaskMappingFactory).create => [
					val task = ContextInjectionFactory.make(SendTestMessageTask, beh)
					put(BehaviourSchemeOneShot.STATE_MAIN, task)
				]
				beh.modify(IBehaviourTaskMapping, mapping)
			]
		}
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