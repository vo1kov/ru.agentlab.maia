package ru.agentlab.maia.execution.action.runnable

import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.AbstractExecutionAction
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.memory.IMaiaContext

class RunnableContextAction extends AbstractExecutionAction {

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
//		val task = context.getService(KEY_TASK)
//		if (task instanceof Runnable) {
//			task.run
//		}
		return null
	}

	override isDone() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override reset() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}