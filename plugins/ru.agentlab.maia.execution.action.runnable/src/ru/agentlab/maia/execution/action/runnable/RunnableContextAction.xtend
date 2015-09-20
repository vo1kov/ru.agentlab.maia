package ru.agentlab.maia.execution.action.runnable

import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.action.AbstractAction
import ru.agentlab.maia.execution.tree.IExecutionScheduler
import ru.agentlab.maia.memory.IMaiaContext

class RunnableContextAction extends AbstractAction {

	@Inject
	IMaiaContext context

	@Accessors
	var IExecutionScheduler parentNode

	override doInject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doUninject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doRun() {
		val task = context.getService(KEY_TASK)
		if (task instanceof Runnable) {
			task.run
		}
		return null
	}

}