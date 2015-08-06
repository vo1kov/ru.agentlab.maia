package ru.agentlab.maia.context.typing.agent

import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorTask
import ru.agentlab.maia.execution.MaiaExecutorTask
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

class MaiaAgentContextInitializer {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			get(IMaiaServiceDeployer) => [
				deploy(SequenceContextScheduler, IMaiaExecutorNode)
				deploy(MaiaExecutorTask, IMaiaExecutorTask)
			]
//
//			val lifecycleScheme = injector.make(FipaLifecycleScheme, it)
//			injector.invoke(lifecycleScheme, PostConstruct, it)
//
//			val lifecycleService = injector.make(LifecycleService, it)
//			injector.invoke(lifecycleService, PostConstruct, it)
//
			set(IMaiaContext.KEY_TYPE, "agent")
			set("debugString", "AGENT " + uuid)

//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}

	@PreDestroy
	def void delete() {
		context => [
			remove(IMaiaContext.KEY_TYPE)
		]
	}
}