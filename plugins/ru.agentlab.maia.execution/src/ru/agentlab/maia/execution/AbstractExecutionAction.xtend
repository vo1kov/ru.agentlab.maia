package ru.agentlab.maia.execution

import java.util.concurrent.atomic.AtomicReference

abstract class AbstractExecutionAction extends AbstractExecutionNode implements IExecutionAction {

	var protected implementation = new AtomicReference<Object>

	override final run() {
		try {
			doInject()
			doRun()
			doUninject()
			
			state.set(ru.agentlab.maia.execution.IExecutionNode.SUCCESS)
			parent.get.notifyChildSuccess
		} catch (Exception e) {
			state.set(ru.agentlab.maia.execution.IExecutionNode.EXCEPTION)
			parent.get.notifyChildException
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