package ru.agentlab.maia.execution.scheduler.sequential

import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.IExecutionNode

abstract class AbstractSequentalScheduler extends AbstractExecutionScheduler {

	val protected static NOT_FOUND = -1

	protected int  index = NOT_FOUND

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
		if (current.get.state == IExecutionNode.READY) {
			return current.get
		}
		index = (index + 1) % childs.size
		return childs.get(index)
	}

	override protected onChildReady(IExecutionNode node) {
		val current = childs.get(index)
		if (current == node) {
			state.set(READY)
			parent.get.markChildReady(this)
		}
	}

	override protected onChildWaiting(IExecutionNode node) {
		state.set(WAITING)
		parent.get.markChildWaiting(this)
	}

	override protected onChildException(IExecutionNode node) {
		state.set(EXCEPTION)
		parent.get.markChildException(this)
	}

}