package ru.agentlab.maia.execution.action.runnable

import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.AbstractAction
import ru.agentlab.maia.execution.tree.IExecutionScheduler

class RunnableContextAction extends AbstractAction {

	@Inject
	IMaiaContext context

	@Accessors
	var IExecutionScheduler parentNode

	new(Class<?> clazz) {
		super(clazz)
	}

	override doInject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doUninject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doRun() {
		val task = context.get(KEY_TASK)
		if (task instanceof Runnable) {
			task.run
		}
		return null
	}

}