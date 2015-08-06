package ru.agentlab.maia.context.typing.agent

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.IMaiaExecutorTask
import ru.agentlab.maia.execution.MaiaExecutorTask
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.IMaiaExecutorNode

class MaiaAgentContextInitializer {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			val injector = get(IMaiaContextInjector)
//
//			val lifecycleScheme = injector.make(FipaLifecycleScheme, it)
//			injector.invoke(lifecycleScheme, PostConstruct, it)
//
//			val lifecycleService = injector.make(LifecycleService, it)
//			injector.invoke(lifecycleService, PostConstruct, it)
//
			val sequenceContextScheduler = injector.make(SequenceContextScheduler)
			injector.invoke(sequenceContextScheduler, PostConstruct)
//			set(IMaiaExecutorScheduler, sequenceContextScheduler)
			set(IMaiaExecutorNode, sequenceContextScheduler)
//
			val maiaTask = injector.make(MaiaExecutorTask)
			injector.invoke(maiaTask, PostConstruct)
			set(IMaiaExecutorTask, maiaTask)
//
			set(IMaiaContext.KEY_TYPE, "agent")
			set("debugString", "AGENT " + uuid)


//			get(IMaiaContextInitializerService).initService(FipaLifecycleScheme)
//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}
}