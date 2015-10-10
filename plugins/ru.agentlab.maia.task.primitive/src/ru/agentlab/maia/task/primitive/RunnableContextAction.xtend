package ru.agentlab.maia.task.primitive

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.PrimitiveTask

class RunnableContextAction extends PrimitiveTask {

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