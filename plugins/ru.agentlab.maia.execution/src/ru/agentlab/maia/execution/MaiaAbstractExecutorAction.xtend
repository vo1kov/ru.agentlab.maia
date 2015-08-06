package ru.agentlab.maia.execution

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

abstract class MaiaAbstractExecutorAction implements IMaiaExecutorAction {

	@Inject
	IMaiaContext context

	@PostConstruct
	def void init() {
		val parentScheduler = context.parent.get(IMaiaExecutorScheduler)
		if (parentScheduler != null) {
			parentScheduler.add(this)
		}
	}

}