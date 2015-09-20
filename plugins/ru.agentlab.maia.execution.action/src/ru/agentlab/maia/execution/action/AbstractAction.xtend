package ru.agentlab.maia.execution.action

import java.util.concurrent.atomic.AtomicReference
import ru.agentlab.maia.execution.node.AbstractNode
import ru.agentlab.maia.execution.tree.IExecutionAction

abstract class AbstractAction extends AbstractNode implements IExecutionAction {

	var protected implementation = new AtomicReference<Object>

	override final run() {
		try {
			doInject()
			doRun()
			doUninject()
		} catch (Exception e) {
			e.printStackTrace
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