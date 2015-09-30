package ru.agentlab.maia.execution.scheduler.sequential

class OneShotSequentialScheduler extends AbstractSequentalScheduler {

	/**
	 * If current node finished then schedule to next node.
	 * If current node is last node finished then change state to finished.
	 */
	override notifyChildSuccess() {
		index++
		if (index >= childs.size) {
			state = SUCCESS
			parent.get.notifyChildSuccess
		} else {
			// Do nothing
		}
	}

}