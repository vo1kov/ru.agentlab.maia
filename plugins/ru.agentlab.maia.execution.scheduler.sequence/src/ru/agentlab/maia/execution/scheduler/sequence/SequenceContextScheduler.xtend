package ru.agentlab.maia.execution.scheduler.sequence

import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.execution.scheduler.AbstractExecutionScheduler

class SequenceContextScheduler extends AbstractExecutionScheduler implements IExecutionScheduler {

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
		current.set(null)
	}

	override synchronized schedule() {
		index = (index + 1) % childs.size
		return childs.get(index)
	}

	override protected onChildChangedState(IExecutionNode node, String oldState, String newState) {
		switch (newState) {
			case UNKNOWN: {
				state = UNKNOWN
			}
			case READY: {
				state = READY
			}
			case IN_WORK: {
				state = IN_WORK
			}
			case WAITING: {
				state = WAITING
			}
			case FINISHED: {
				for (ch : childs) {
					if (!ch.state.equals(FINISHED)) {
						return
					}
				}
				state = FINISHED
			}
			case EXCEPTION: {
				state = EXCEPTION
			}
			default: {
				throw new IllegalStateException("Unknown child node state - [" + newState + "]")
			}
		}
	}

}