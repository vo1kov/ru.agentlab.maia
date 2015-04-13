package ru.agentlab.maia.execution.action.runnable

import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction

class RunnableContextAction implements IMaiaContextAction {

	@Inject
	IMaiaContext context

	override beforeRun() {
	}

	override run() {
		val task = context.get(KEY_TASK)
		if (task instanceof Runnable) {
			task.run
		}
		return null
	}

	override afterRun() {
	}

}