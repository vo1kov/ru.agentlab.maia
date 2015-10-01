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
					node.run
					if (node.state != IExecutionNode.State.SUCCESS) {
						executor.submit(this)
					}
				}
			}
		})
	}

	override void stop() {
		isActive.set(false)
	}

	override isActive() {
		isActive.get
	}

}