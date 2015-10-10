package ru.agentlab.maia.execution.action.annotated

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.TaskPrimitive

class RunnableContextAction extends TaskPrimitive {

	@Accessors
	var ITaskScheduler parentNode

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
	
	override reset() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}