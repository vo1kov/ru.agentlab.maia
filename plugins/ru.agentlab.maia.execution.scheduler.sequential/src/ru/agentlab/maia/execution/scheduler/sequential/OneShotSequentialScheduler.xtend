package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.IExecutionNode

class OneShotSequentialScheduler extends AbstractSequentalScheduler {

	/**
	 * If current node finished then schedule to next node.
	 * If current node is last node finished then change state to finished.
	 */
	override protected onChildFinished(IExecutionNode node) {
		val current = childs.get(index)
		if (current == node) {
			index++
			if (index >= childs.size) {
				state.set(FINISHED)
				parent.get.markChildFinished(this)
			} else {
				// Do nothing
			}
		} else {
			// Do nothing
		}
	}

}