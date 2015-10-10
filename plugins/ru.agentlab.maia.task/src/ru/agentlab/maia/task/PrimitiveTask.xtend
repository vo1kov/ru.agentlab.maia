package ru.agentlab.maia.task

import java.util.concurrent.atomic.AtomicReference

abstract class PrimitiveTask extends Task {

	var protected implementation = new AtomicReference<Object>

	override protected internalExecute() {
		try {
			doInject()
			doRun()
			doUninject()

			state = State.SUCCESS
		} catch (Exception e) {
			state = State.FAILED
		}
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}