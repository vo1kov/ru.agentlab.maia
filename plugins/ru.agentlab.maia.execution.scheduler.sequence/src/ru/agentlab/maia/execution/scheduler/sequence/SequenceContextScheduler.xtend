package ru.agentlab.maia.execution.scheduler.sequence

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.impl.AbstractScheduler

class SequenceContextScheduler extends AbstractScheduler {

	int index = -1

	@Accessors
	var volatile IExecutionNode currentChild

//	boolean ready = false
//	/**
//	 * Queue of available nodes.
//	 */
//	protected List<IExecutionNode> nodes = new ArrayList<IExecutionNode>
//	/**
//	 * <p>Add a context at the end of the nodes queue.</p>
//	 * 
//	 * <p>When you add a node to scheduler first time it try to update parent scheduler and add self
//	 * to parent scheduler.</p>
//	 * 
//	 * @param
//	 * 		node - node to be added from scheduler.
//	 */
//	override synchronized void addChild(IExecutionNode node) {
//		if (nodes.empty) {
//			nodes += node
//			ready = true
//		} else {
//			if (!nodes.contains(node)) {
//				nodes += node
//			}
//		}
//	}
	/**
	 * <p>Removes a specified node from the nodes queue.</p>
	 * 
	 * <p>When remove last node it removes self from parent scheduler and forget about parent scheduler.
	 * It is necessary to avoid changes in hierarchy of contexts when scheduler is inactive.</p>
	 * 
	 * @param
	 * 		node - node to be removed from scheduler.
	 */
	override synchronized void removeChild(IExecutionNode node) {
		val i = childs.indexOf(node)
		if (i != -1) {
			childs.remove(node)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == childs.size()) {
				index = 0
			}
		}
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		super.removeAll()
		index = 0
	}

	override synchronized getNextChild() {
		if (childs.empty) {
			currentChild = null
		} else {
			index = (index + 1) % childs.size
			currentChild = childs.get(index)
		}
		return currentChild
	}

}