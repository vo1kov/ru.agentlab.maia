package ru.agentlab.maia.execution.action.runnable

import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.IMaiaExecutorAction
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

class RunnableContextAction implements IMaiaExecutorAction {

	@Inject
	IMaiaContext context

	@Accessors
	var IMaiaExecutorScheduler parentNode

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