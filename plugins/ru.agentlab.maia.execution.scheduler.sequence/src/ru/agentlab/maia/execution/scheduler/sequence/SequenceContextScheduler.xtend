package ru.agentlab.maia.execution.scheduler.sequence

import ru.agentlab.maia.execution.AbstractScheduler
import ru.agentlab.maia.execution.IMaiaExecutorNode

class SequenceContextScheduler extends AbstractScheduler {

	private int index = 0

	override synchronized IMaiaExecutorNode getCurrentNode() {
		return nodes.get(index)
	}

	override synchronized void remove(IMaiaExecutorNode node) {
		val i = nodes.indexOf(node)
		if (i != -1) {
			nodes.remove(node)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == nodes.size())
				index = 0
		}
		super.remove(node)
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override synchronized void removeAll() {
		super.removeAll()
		index = 0
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