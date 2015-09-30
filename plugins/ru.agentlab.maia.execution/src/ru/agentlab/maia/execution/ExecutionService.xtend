package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

class ExecutionService implements IExecutionService {

	@Inject
	ExecutorService executor

	@Inject
	IExecutionNode node

	val isActive = new AtomicBoolean(false)

	override void start() {
		isActive.set(true)
		executor.submit(new Runnable {
			override run() {
				if (active) {
					val action = node.action
					if (action != null) {
						action.run
					}
					if (node.state != IExecutionNode.ru.agentlab.maia.execution.IExecutionNode.SUCCESSFULLY) {
						executor.submit(this)
					}
				}
			}
		})
	}

	def IExecutionAction getAction(IExecutionNode node) {
		if (node instanceof IExecutionAction) {
			return node
		}
		if (node instanceof IExecutionScheduler) {
			return node.node.action
		}
	}

	override void stop() {
		isActive.set(false)
	}

	override isActive() {
		isActive.get
	}

}