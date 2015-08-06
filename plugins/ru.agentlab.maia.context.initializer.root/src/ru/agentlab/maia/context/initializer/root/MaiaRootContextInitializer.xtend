package ru.agentlab.maia.context.initializer.root

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.execution.lifecycle.fipa.FipaLifecycleScheme

class MaiaRootContextInitializer {

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
			set(IMaiaContext.KEY_TYPE, "root")
//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorScheduler, sequenceContextScheduler)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}
}