package ru.agentlab.maia.execution

import java.util.concurrent.atomic.AtomicReference

abstract class AbstractExecutionAction extends AbstractExecutionNode implements IExecutionAction {

	var protected implementation = new AtomicReference<Object>

	override final run() {
		try {
			doInject()
			doRun()
			doUninject()
			
			state.set(FINISHED)
			parent.get.markChildFinished(this)
		} catch (Exception e) {
			state.set(EXCEPTION)
			parent.get.markChildException(this)
		}
	}

	override getImplementation() {
		implementation.get
	}

	override setImplementation(Object impl) {
		implementation.set(impl)
	}

	abstract def void doInject()

	abstract def void doUninject()

	abstract def Object doRun()

}