package ru.agentlab.maia.execution.scheduler

import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicReference
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.execution.node.AbstractExecutionNode

abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	val protected childs = new CopyOnWriteArrayList<IExecutionNode>

	val protected current = new AtomicReference<IExecutionNode>

	override run() {
		val next = schedule()
		next.run()
	}

	override addChild(IExecutionNode child) {
		if (child == null) {
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		if (childs.addIfAbsent(child)) {
		}
	}

	override isEmpty() {
		return childs.empty
	}
	
	def protected void onChildChangedState(IExecutionNode node, String oldState, String newState)

	/** 
	 * Removes all nodes from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 */
	override removeAll() {
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
	override removeChild(IExecutionNode node) {
		if (node == null) {
			throw new IllegalArgumentException("Node parameter should be not null")
		}
		return childs.remove(node)
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

	override getChilds() {
		return childs.iterator
	}

}