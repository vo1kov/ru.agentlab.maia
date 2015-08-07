package ru.agentlab.maia.execution.scheduler.sequence

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.AbstractScheduler
import ru.agentlab.maia.execution.IMaiaExecutorNode

class SequenceContextScheduler extends AbstractScheduler {

	private int index = 0

	/**
	 * Queue of available nodes.
	 */
	protected List<IMaiaExecutorNode> nodes = new ArrayList<IMaiaExecutorNode>

	/**
	 * <p>Add a context at the end of the nodes queue.</p>
	 * 
	 * <p>When you add a node to scheduler first time it try to update parent scheduler and add self
	 * to parent scheduler.</p>
	 * 
	 * @param
	 * 		node - node to be added from scheduler.
	 */
	override synchronized void add(IMaiaExecutorNode node) {
		if (nodes.empty) {
			nodes += node
			ready = true
		} else {
			if (!nodes.contains(node)) {
				nodes += node
			}
		}
	}

	override synchronized IMaiaExecutorNode getCurrentNode() {
		return nodes.get(index)
	}

	/**
	 * <p>Removes a specified node from the nodes queue.</p>
	 * 
	 * <p>When remove last node it removes self from parent scheduler and forget about parent scheduler.
	 * It is necessary to avoid changes in hierarchy of contexts when scheduler is inactive.</p>
	 * 
	 * @param
	 * 		node - node to be removed from scheduler.
	 */
	override synchronized void remove(IMaiaExecutorNode node) {
		val i = nodes.indexOf(node)
		if (i != -1) {
			nodes.remove(node)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == nodes.size()) {
				index = 0
			}
			if (empty) {
				ready = false
			}
		}
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		nodes.clear
		index = 0
		ready = false
	}

	override synchronized isEmpty() {
		return nodes.empty
	}

	override synchronized getNextNode() {
		if (nodes.empty) {
			return null
		} else {
			index = (index + 1) % nodes.size
			return nodes.get(index)
		}
	}

}