package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

class MaiaBehaviourContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			get(IMaiaServiceDeployer) => [
				deploy(SequenceContextScheduler, IMaiaExecutorNode)
			]
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
			set(IMaiaContext.KEY_TYPE, "behaviour")
//			set(IMaiaContextLifecycleScheme, lifecycleScheme)
//			set(IMaiaContextLifecycleService, lifecycleService)
//			set(IMaiaExecutorScheduler, sequenceContextScheduler)
//			set(IMaiaExecutorService, maiaExecutorService)
//			set(IMaiaContextInitializerService, MaiaContextInitializerService)
		]
	}
}