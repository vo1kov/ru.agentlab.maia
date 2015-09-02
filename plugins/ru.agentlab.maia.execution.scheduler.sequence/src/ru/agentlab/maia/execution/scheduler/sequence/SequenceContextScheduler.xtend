package ru.agentlab.maia.execution.scheduler.sequence

import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IllegalSchedulerStateException
import ru.agentlab.maia.execution.tree.impl.AbstractScheduler

class SequenceContextScheduler extends AbstractScheduler {

	val static UNKNOWN = -1

	int index = UNKNOWN

	/**
	 * <p>Removes a specified node from the nodes queue.</p>
	 * 
	 * <p>When remove last node it removes self from parent scheduler and forget about parent scheduler.
	 * It is necessary to avoid changes in hierarchy of contexts when scheduler is inactive.</p>
	 * 
	 * @param
	 * 		node - node to be removed from scheduler.
	 */
	override synchronized removeChild(IExecutionNode node) {
		if (node == null) {
			return null
		}
		val i = childs.indexOf(node)
		if (i != UNKNOWN) {
			val result = super.removeChild(node)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == childs.size()) {
				index = 0
			}
			return result
		} else {
			return null
		}
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		super.removeAll()
		index = UNKNOWN
		current = null
	}

	override synchronized schedule() throws IllegalSchedulerStateException {
		if (state != ExecutionNodeState.ACTIVE) {
			throw new IllegalSchedulerStateException("Only Scheduler in ACTIVE state can schedule.")
		}
		if (childs.empty) {
			current = null
		} else {
			index = (index + 1) % childs.size
			current = childs.get(index)
		}
		return current
	}

}