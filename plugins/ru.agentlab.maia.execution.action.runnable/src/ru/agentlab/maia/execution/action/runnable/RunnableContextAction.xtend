package ru.agentlab.maia.execution.action.runnable

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.AbstractExecutionAction
import ru.agentlab.maia.execution.IExecutionScheduler

class RunnableContextAction extends AbstractExecutionAction {

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

}