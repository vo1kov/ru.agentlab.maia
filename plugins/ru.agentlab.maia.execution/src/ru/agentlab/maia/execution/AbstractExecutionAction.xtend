package ru.agentlab.maia.execution

import java.util.concurrent.atomic.AtomicReference

abstract class AbstractExecutionAction extends AbstractExecutionNode implements IExecutionAction {

	var protected implementation = new AtomicReference<Object>
	
	override protected runInternal() {
		try {
			doInject()
			doRun()
			doUninject()

			state = State.SUCCESS
			parent.get.notifyChildSuccess
		} catch (Exception e) {
			state = State.FAILED
			parent.get.notifyChildFailed
		}
	}

	def getImplementation() {
		implementation.get
	}

	def setImplementation(Object impl) {
		implementation.set(impl)
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}