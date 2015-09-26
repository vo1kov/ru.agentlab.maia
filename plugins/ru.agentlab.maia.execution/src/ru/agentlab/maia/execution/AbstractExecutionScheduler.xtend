package ru.agentlab.maia.execution

import java.util.ArrayList
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	@Accessors
	val protected childs = new ArrayList<IExecutionNode>

	val protected current = new AtomicReference<IExecutionNode>

	override markChildReady(IExecutionNode node) {
		node.checkValid
		onChildReady(node)
	}

	override markChildWaiting(IExecutionNode node) {
		node.checkValid
		onChildWaiting(node)
	}

	override markChildFinished(IExecutionNode node) {
		node.checkValid
		onChildFinished(node)
	}

	override markChildException(IExecutionNode node) {
		node.checkValid
		onChildException(node)
	}

	def protected void onChildReady(IExecutionNode node)

	def protected void onChildWaiting(IExecutionNode node)

	def protected void onChildFinished(IExecutionNode node)

	def protected void onChildException(IExecutionNode node)

	def private checkValid(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!childs.contains(node)) {
			throw new IllegalArgumentException("Scheduler [" + this + "] have no child node [" + node + "]")
		}
	}

	override synchronized addChild(IExecutionNode node) {
		node.checkValid
		childs.add(node)
	}

	override synchronized reset() {
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
		node.checkValid
		childs.remove(node)
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