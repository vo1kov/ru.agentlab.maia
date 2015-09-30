package ru.agentlab.maia.execution

import java.util.concurrent.atomic.AtomicReference

abstract class AbstractExecutionAction extends AbstractExecutionNode implements IExecutionAction {

	var protected implementation = new AtomicReference<Object>

	override run() {
		try {
			state = IN_WORK

			doInject()
			doRun()
			doUninject()

			state = SUCCESS
			parent.get.notifyChildSuccess
		} catch (Exception e) {
			state = EXCEPTION
			parent.get.notifyChildException
		}
	}

	override getImplementation() {
		implementation.get
	}

	override setImplementation(Object impl) {
		implementation.set(impl)
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}