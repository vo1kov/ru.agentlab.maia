package ru.agentlab.maia.execution.action.annotated

import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.injector.IMaiaContextInjector

class AnnotatedContextAction implements IMaiaContextAction {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	override beforeAction() {
	}

	override action() {
		val task = context.get(KEY_TASK)
		if (task != null) {
			return injector.invoke(task, Action, context)
		}
	}

	override afterAction() {
	}

}