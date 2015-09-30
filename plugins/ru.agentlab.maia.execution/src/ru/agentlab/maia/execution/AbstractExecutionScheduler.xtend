package ru.agentlab.maia.execution

import java.util.ArrayList

abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	protected int index = 0

	val protected childs = new ArrayList<IExecutionNode>

	override addChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!childs.contains(node)) {
			childs += node
			node.parent = this
		} else {
			// Do nothing
		}
	}

	override reset() {
		for (child : childs) {
			child.reset
		}
	}

	override getChilds() {
		return childs
	}

	/** 
	 * Removes all nodes from the queue.
	 */
	override removeAll() {
		childs.clear
		index = 0
	}

	/** 
	 * Removes specified node from the queue.
	 * 
	 * @param node - node to be deleted
	 * 
	 * @return node previously at the scheduler 
	 */
	override removeChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(node)
		if (i != -1) {
			childs.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == childs.size()) {
				index = 0
			}
			return true
		} else {
			return false
		}
	}

	override getNode() {
		return childs.get(index)
	}

}