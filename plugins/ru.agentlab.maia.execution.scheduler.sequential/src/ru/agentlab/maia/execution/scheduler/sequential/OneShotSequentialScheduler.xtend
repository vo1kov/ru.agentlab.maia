package ru.agentlab.maia.execution.scheduler.sequential

class OneShotSequentialScheduler extends AbstractSequentalScheduler {

	/**
	 * If current node finished then schedule to next node.
	 * If current node is last node finished then change state to finished.
	 */
	override notifyChildFinished() {
		index++
		if (index >= childs.size) {
			state.set(ru.agentlab.maia.execution.IExecutionNode.SUCCESS)
			parent.get.notifyChildSuccess
		} else {
			// Do nothing
		}
	}
	
}