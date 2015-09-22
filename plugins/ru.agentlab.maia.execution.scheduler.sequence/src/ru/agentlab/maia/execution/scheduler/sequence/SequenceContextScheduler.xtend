package ru.agentlab.maia.execution.scheduler.sequence

import ru.agentlab.maia.execution.scheduler.AbstractScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler
import ru.agentlab.maia.execution.tree.IllegalSchedulerStateException

class SequenceContextScheduler extends AbstractScheduler implements IExecutionScheduler {

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
		if (state != IExecutionNode.IN_WORK) {
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

	/**
	 * Scheduler becomes UNKNOWN when any of child nodes become UNKNOWN
	 */
	override handleChildUnknown(IExecutionNode child) {
		state.set(UNKNOWN)
	}

	/**
	 * Scheduler becomes READY when all child nodes become READY 
	 */
	override handleChildReady(IExecutionNode child) {
		for (ch : childs) {
			if (ch.state != READY) {
				return
			}
		}
		state.set(READY)
	}

	/**
	 * Scheduler becomes IN_WORK when any of child nodes become IN_WORK
	 */
	override handleChildInWork(IExecutionNode child) {
		state.set(IN_WORK)
	}

	/**
	 * Scheduler becomes WAITING when any of child nodes become WAITING
	 */
	override handleChildWait(IExecutionNode child) {
		state.set(WAITING)
	}

	/**
	 * Scheduler becomes FINISHED when all child nodes become FINISHED
	 */
	override handleChildFinish(IExecutionNode child) {
		for (ch : childs) {
			if (ch.state != FINISHED) {
				return
			}
		}
		if (repeatCounts.getAndDecrement != 0) {
			for (ch : childs) {
				ch.activate
			}
		} else {
			state.set(FINISHED)
		}
	}

}