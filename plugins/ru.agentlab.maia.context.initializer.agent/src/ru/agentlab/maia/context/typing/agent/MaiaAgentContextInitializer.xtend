package ru.agentlab.maia.context.typing.agent

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.IMaiaExecutorService
import ru.agentlab.maia.execution.MaiaExecutorService
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleScheme
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleService
import ru.agentlab.maia.execution.lifecycle.LifecycleService
import ru.agentlab.maia.execution.lifecycle.fipa.FipaLifecycleScheme
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

class MaiaAgentContextInitializer {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
//			val injector = get(IMaiaContextInjector)
//
//			val lifecycleScheme = injector.make(FipaLifecycleScheme, it)
//			injector.invoke(lifecycleScheme, PostConstruct, it)
//
//			val lifecycleService = injector.make(LifecycleService, it)
//			injector.invoke(lifecycleService, PostConstruct, it)
//
//			val sequenceContextScheduler = injector.make(SequenceContextScheduler, it)
//			injector.invoke(sequenceContextScheduler, PostConstruct, it)
//
//			val maiaExecutorService = injector.make(MaiaExecutorService, it)
//			injector.invoke(maiaExecutorService, PostConstruct, it)
//
			set(IMaiaContext.KEY_TYPE, "agent")
			set("debugString", "AGENT " + uuid)
//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorScheduler, sequenceContextScheduler)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}
}