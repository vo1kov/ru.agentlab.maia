package ru.agentlab.maia.behaviour

import java.util.UUID
import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicReference
import javax.inject.Inject

/**
 * 
 * @author Dmitry Shishkin
 */
class Agent implements IAgent {
	
	val UUID uuid = UUID.randomUUID

	ExecutorService executor

	val behaviour = new AtomicReference<Behaviour>

	val isActive = new AtomicBoolean(false)

	@Inject
	new(ExecutorService executor) {
		this.executor = executor
	}
	
	override final UUID getUuid() {
		return uuid
	}

	override void start() {
		isActive.set(true)
		executor.submit(
			new Runnable {
				override run() {
					if (active) {
						behaviour.get.execute
						if (behaviour.get.state != BehaviourState.SUCCESS) {
							executor.submit(this)
						}
					}
				}
			}
		)
	}

	override void stop() {
		this.isActive.set(false)
	}

	override isActive() {
		this.isActive.get
	}

	override setBehaviour(Behaviour behaviour) {
		this.behaviour.set(behaviour)
	}

	override getBehaviour() {
		this.behaviour.get
	}

}