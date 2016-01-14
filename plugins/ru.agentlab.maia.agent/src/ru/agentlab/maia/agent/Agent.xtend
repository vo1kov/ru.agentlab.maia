package ru.agentlab.maia.agent

import java.util.UUID
import java.util.concurrent.ConcurrentLinkedQueue
import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import java.util.concurrent.atomic.AtomicReference
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IAgent
import ru.agentlab.maia.IAgent.State
import ru.agentlab.maia.IBehaviour

/**
 * 
 * @author Dmitry Shishkin
 */
class Agent implements IAgent {

	@Accessors
	val UUID uuid = UUID.randomUUID

	var ExecutorService executor

	val behaviour = new AtomicReference<IBehaviour>

	val isActive = new AtomicBoolean(false)

	var protected State state = State.UNKNOWN

	val queue = new ConcurrentLinkedQueue<Runnable>

	var submittedToExecutor = new AtomicBoolean(false)

	@Inject
	new(ExecutorService executor) {
		this.executor = executor
	}

	def submit(Runnable runnable) {
		val task = runnable.wrapTask
		queue.offer(task)
		println("OFFER queue: " + queue)
		if (!submittedToExecutor.get) {
			sheduleNext
		} else {
			// Do nothing. Wait when submitted task will submit next from queue
		}
	}

	/**
	 * Wrap runnable to know when agent can submit new task
	 */
	def private Runnable wrapTask(Runnable runnable) {
		new Runnable {

			override run() {
				runnable.run
				submittedToExecutor.set(false)
				sheduleNext
			}

			override toString() {
				runnable.toString()
			}

		}
	}

	/**
	 * Retrieve last task in queue and submit it to ExecutorService 
	 */
	def private void sheduleNext() {
		val task = queue.poll
		println("POLL queue: " + queue)
		if (task != null) {
			submittedToExecutor.set(true)
			executor.submit(task)
		} else {
			// Do nothing. Queue is empty
		}
	}

	override void start() {
		isActive.set(true)
		submit(new Runnable {

			override run() {
				state = State.ACTIVE
				behaviour.get.execute
				switch (behaviour.get.state) {
					case UNKNOWN: {
					}
					case READY: {
					}
					case BLOCKED: {
						state = State.WAITING
					}
					case WORKING: {
						if (active) {
							submit(this)
						}
					}
					case SUCCESS: {
						if (active) {
							submit(this)
						}
					}
					case FAILED: {
						state = State.SUSPENDED
					}
				}
			}

			override toString() {
				behaviour.get.toString()
			}

		})
	}

	override void stop() {
		this.isActive.set(false)
	}

	override isActive() {
		this.isActive.get
	}

	override setBehaviour(IBehaviour behaviour) {
		this.behaviour.set(behaviour)
	}

	override getBehaviour() {
		this.behaviour.get
	}
	
	override getContainer() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
