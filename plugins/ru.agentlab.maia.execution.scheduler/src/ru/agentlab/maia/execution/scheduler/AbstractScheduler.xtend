package ru.agentlab.maia.execution.scheduler

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.check.IChildsCheck
import ru.agentlab.maia.execution.node.AbstractNode
import ru.agentlab.maia.execution.node.DataLink
import ru.agentlab.maia.execution.tree.IDataLink
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

@Accessors
abstract class AbstractScheduler extends AbstractNode implements IExecutionScheduler {

	val dataLinks = new ArrayList<IDataLink>

	val childs = new ArrayList<IExecutionNode>

	val childChecklist = new ArrayList<IChildsCheck>

	var IExecutionNode current

	override run() {
		schedule?.run
	}

	override synchronized notifyChildActivation(IExecutionNode node) {
		testChilds()
	}

	override synchronized notifyChildDeactivation(IExecutionNode node) {
		testChilds()
	}

	def synchronized void addLink(IDataParameter<?> from, IDataParameter<?> to) {
		if (from.key != null && from.key.length > 0) {
			to.key = from.key
		}
		getDataLinks += new DataLink(from, to)
	}

	override synchronized void addChild(IExecutionNode child) {
		if (child == null) {
			return
		}
		if (!getChilds.contains(child)) {
			getChilds += child
			testChilds()
		}
	}

	override synchronized isEmpty() {
		return getChilds.empty
	}

	/** 
	 * Removes all nodes from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 */
	override synchronized void removeAll() {
		getChilds.clear
		testChilds()
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
			return null
		}
		val index = getChilds.indexOf(node)
		if (index != -1) {
			val removed = getChilds.remove(index)
			testChilds()
			if (getChilds.length == 0) {
				setCurrent = null
			}
			return removed
		} else {
			return null
		}
	}

	def protected void testChilds() {
		for (check : getChildChecklist) {
			if (!check.test(getChilds)) {
				block()
				return
			}
			if (!check.test(getChilds)) {
				block()
				return
			}
		}
		activate()
	}

	override synchronized IExecutionNode getCurrent() {
		return current
	}

	override synchronized List<IExecutionNode> getChilds() {
		return childs
	}

	override synchronized List<IDataLink> getDataLinks() {
		return dataLinks
	}

}