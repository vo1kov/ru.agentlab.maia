package ru.agentlab.maia.execution.scheduler.sequence

import ru.agentlab.maia.execution.scheduler.AbstractScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

class SequenceContextScheduler extends AbstractScheduler implements IExecutionScheduler {

	val static NOT_FOUND = -1

	int index = NOT_FOUND

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
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		val i = childs.indexOf(node)
		if (i != NOT_FOUND) {
			val result = super.removeChild(node)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == childs.size()) {
				index = 0
			}
			return result
		} else {
			return false
		}
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		super.removeAll()
		index = NOT_FOUND
		current = null
	}

	override synchronized schedule() {
		index = (index + 1) % childs.size
		return childs.get(index)
	}

	override handleChildChangedState(IExecutionNode child, int oldState, int newState) {
		switch (newState) {
			case UNKNOWN: {
				state.set(UNKNOWN)
			}
			case READY: {
				for (ch : childs) {
					if (ch.state != READY) {
						return
					}
				}
				state.set(READY)
			}
			case IN_WORK: {
				state.set(IN_WORK)
			}
			case WAITING: {
				state.set(WAITING)
			}
			case FINISHED: {
				for (ch : childs) {
					if (ch.state != FINISHED) {
						return
					}
				}
				if (repeatCounts.getAndDecrement != 0) {
					for (ch : childs) {
						state.set(READY)
					}
				} else {
					state.set(FINISHED)
				}
			}
		}
	}

}