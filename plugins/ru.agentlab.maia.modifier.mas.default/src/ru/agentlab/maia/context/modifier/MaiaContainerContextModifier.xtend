package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskExecutor
import ru.agentlab.maia.execution.TaskExecutor
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector

class MaiaContainerContextModifier {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void setup() {
		context => [
			putService(IMaiaContext.KEY_TYPE, "container")
			getService(IMaiaContextInjector) => [
				deploy(SequentialTaskScheduler, ITask)
				deploy(TaskExecutor, ITaskExecutor)
			]
		]
	}
}