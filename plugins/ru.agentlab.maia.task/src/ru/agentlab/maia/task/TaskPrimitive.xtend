package ru.agentlab.maia.task

import java.util.concurrent.atomic.AtomicReference

abstract class TaskPrimitive extends Task {

	var protected implementation = new AtomicReference<Object>

	override protected internalExecute() {
		try {
			doInject()
			doRun()
			doUninject()

			state = TaskState.SUCCESS
		} catch (Exception e) {
			state = TaskState.FAILED
		}
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}