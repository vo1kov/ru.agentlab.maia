package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.IExecutionNode

abstract class AbstractSequentalScheduler extends AbstractExecutionScheduler {

	override notifyChildReady(IExecutionNode node) {
		val current = childs.get(index)
		if (current == node) {
			state.set(READY)
			parent.get.notifyChildReady(this)
		}
	}

	override notifyChildBlocked() {
		state.set(IExecutionNode.BLOCKED)
		parent.get.notifyChildBlocked
	}

	override notifyChildException() {
		state.set(IExecutionNode.EXCEPTION)
		parent.get.notifyChildException
	}

}