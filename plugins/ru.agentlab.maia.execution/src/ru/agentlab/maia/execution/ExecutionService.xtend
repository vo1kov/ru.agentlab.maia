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
				if (isActive.get) {
					node.run
					executor.submit(this)
				}
			}
		})
	}

	def void submit(IExecutionNode node) {
	}

	override void stop() {
		isActive.set(false)
	}

}