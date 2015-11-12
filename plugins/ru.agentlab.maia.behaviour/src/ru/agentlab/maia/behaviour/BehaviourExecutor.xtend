package ru.agentlab.maia.behaviour

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

class BehaviourExecutor implements IBehaviourExecutor {

	@Inject
	ExecutorService executor

	@Inject
	IBehaviour task

	val isActive = new AtomicBoolean(false)

	override void start() {
		isActive.set(true)
		executor.submit(
			new Runnable {
				override run() {
					if (active) {
						task.execute
						if (task.state != ru.agentlab.maia.behaviour.BehaviourState.SUCCESS) {
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