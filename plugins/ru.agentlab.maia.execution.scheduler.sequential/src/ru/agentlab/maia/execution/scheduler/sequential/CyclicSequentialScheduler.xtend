package ru.agentlab.maia.execution.scheduler.sequential

class CyclicSequentialScheduler extends AbstractSequentalScheduler {

	/**
	 * If current node finished then schedule to next node.
	 * Should never be finished.
	 */
	override notifyChildSuccess() {
		index = (index + 1) % childs.size
	}

}