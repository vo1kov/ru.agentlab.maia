package ru.agentlab.maia.execution.performer

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskPerformer

class TaskPerformer implements ITaskPerformer {

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
						task.run
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