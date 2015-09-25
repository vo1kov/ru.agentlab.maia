package ru.agentlab.maia.execution

import java.util.ArrayList
import java.util.BitSet
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	@Accessors
	val protected childs = new ArrayList<IExecutionNode>

	val protected current = new AtomicReference<IExecutionNode>

	val protected inworkChilds = new BitSet

	val protected waitingChilds = new BitSet

	val protected finishedChilds = new BitSet

	val protected exceptionChilds = new BitSet

	override synchronized markChildReady(IExecutionNode node) {
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, false)
			waitingChilds.set(index, false)
			finishedChilds.set(index, false)
			exceptionChilds.set(index, false)
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized markChildInWork(IExecutionNode node) {
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, true)
			waitingChilds.set(index, false)
			finishedChilds.set(index, false)
			exceptionChilds.set(index, false)
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized markChildWaiting(IExecutionNode node) {
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, false)
			waitingChilds.set(index, true)
			finishedChilds.set(index, false)
			exceptionChilds.set(index, false)
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized markChildFinished(IExecutionNode node) {
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, false)
			waitingChilds.set(index, false)
			finishedChilds.set(index, true)
			exceptionChilds.set(index, false)
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized markChildException(IExecutionNode node) {
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, false)
			waitingChilds.set(index, false)
			finishedChilds.set(index, false)
			exceptionChilds.set(index, true)
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized addChild(IExecutionNode node) {
		if (node == null) {
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		val index = childs.indexOf(node)
		if (index == -1) {
			childs.add(node)
		}
	}

	override synchronized reset() {
		inworkChilds.clear
		waitingChilds.clear
		finishedChilds.clear
		exceptionChilds.clear
		for (child : childs) {
			child.reset
		}
	}

	/** 
	 * Removes all nodes from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 */
	override synchronized removeAll() {
		childs.clear
		inworkChilds.clear
		waitingChilds.clear
		finishedChilds.clear
		exceptionChilds.clear
	}

	/** 
	 * Removes specified node from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 * 
	 * @param node - node to be deleted
	 * 
	 * @return node previously at the scheduler 
	 */
	override synchronized removeChild(IExecutionNode node) {
		if (node == null) {
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		val index = childs.indexOf(node)
		if (index != -1) {
			inworkChilds.set(index, false)
			waitingChilds.set(index, false)
			finishedChilds.set(index, false)
			exceptionChilds.set(index, true)
			childs.remove(index)
			return true
		} else {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override getCurrent() {
		return current.get
	}

	override setCurrent(IExecutionNode node) {
		if (node == null) {
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		return current.getAndSet(node)
	}

}