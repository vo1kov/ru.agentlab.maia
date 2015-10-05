package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

class TaskExecutor implements ITaskExecutor {

	@Inject
	ExecutorService executor

	@Inject
	ITask task

	val isActive = new AtomicBoolean(false)

	override void start() {
		isActive.set(true)
		executor.submit(
			new Runnable {
				override run() {
					if (active) {
						task.execute
						if (task.state != ITask.State.SUCCESS) {
							executor.submit(this)
						}
					}
				}
			}
		)
	}

	override void stop() {
		isActive.set(false)
	}

	override isActive() {
		isActive.get
	}

}