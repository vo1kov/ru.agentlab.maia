package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.IExecutionNode

class CyclicSequentialScheduler extends AbstractSequentalScheduler {

	/**
	 * If current node finished then schedule to next node.
	 * Should never be finished.
	 */
	override protected onChildFinished(IExecutionNode node) {
		val current = childs.get(index)
		if (current == node) {
			index = (index + 1) % childs.size
		} else {
			// Do nothing
		}
	}

}