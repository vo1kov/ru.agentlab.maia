package ru.agentlab.maia.execution.action.annotated

import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.execution.action.IMaiaContextAction

class AnnotatedContextAction implements IMaiaContextAction {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	override beforeRun() {
	}

	override run() {
		val task = context.get(KEY_TASK)
		if (task != null) {
			return injector.invoke(task, Action, context)
		}
	}

	override afterRun() {
	}

}