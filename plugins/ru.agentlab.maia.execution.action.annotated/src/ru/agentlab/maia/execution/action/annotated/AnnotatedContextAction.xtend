package ru.agentlab.maia.execution.action.annotated

import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.MaiaAbstractExecutorAction

class AnnotatedContextAction extends MaiaAbstractExecutorAction {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	var IMaiaExecutorScheduler parentSchedulr

	override run() {
		val task = context.get(KEY_TASK)
		if (task != null) {
			afterRun
			return injector.invoke(task, Action)
		} else {
			afterRun
			return null
		}
	}

	def afterRun() {
		parentSchedulr.remove(this)
	}

}