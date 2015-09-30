package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.ExceptionHandling
import ru.agentlab.maia.execution.IExecutionNode

abstract class AbstractSequentalScheduler extends AbstractExecutionScheduler {

	var byte failHandling = ExceptionHandling.SKIP

	override notifyChildReady(IExecutionNode node) {
		val current = childs.get(index)
		if (current == node) {
			state = READY
			parent.get.notifyChildReady(this)
		}
	}

	override notifyChildBlocked() {
		state = BLOCKED
		parent.get.notifyChildBlocked
	}

	override notifyChildException() {
		switch (failHandling) {
			case ExceptionHandling.FAIL: {
				state = EXCEPTION
				parent.get?.notifyChildException
			}
			case ExceptionHandling.SKIP: {
				schedule()
			}
			case ExceptionHandling.BLOCK: {
				state = EXCEPTION
				parent.get?.notifyChildException
			}
			case ExceptionHandling.RESTART: {
				reset()
			}
			default: {
				throw new IllegalStateException("Unknown fail handling: " + failHandling)
			}
		}
	}

	def protected void schedule()

}