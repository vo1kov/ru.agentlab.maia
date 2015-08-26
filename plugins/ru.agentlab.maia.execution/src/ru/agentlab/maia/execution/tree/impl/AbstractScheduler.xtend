package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.check.IChildsCheck
import ru.agentlab.maia.execution.tree.IDataLink
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

abstract class AbstractScheduler extends AbstractNode implements IExecutionScheduler {

	@Accessors
	val protected dataLinks = new ArrayList<IDataLink>

	@Accessors
	val protected childs = new ArrayList<IExecutionNode>

	@Accessors
	val protected childChecklist = new ArrayList<IChildsCheck>

	override run() {
		var IExecutionNode node = null
		synchronized (this) {
			node = nextChild
		}
		node?.run
	}

	override synchronized notifyChildActivation(IExecutionNode node) {
		testChilds()
	}

	override synchronized notifyChildDeactivation(IExecutionNode node) {
		testChilds()
	}

	def synchronized void addLink(IDataParameter from, IDataParameter to) {
		if (from.key != null && from.key.length > 0) {
			to.key = from.key
		}
		dataLinks += new DataLink(from, to)
	}

	override synchronized void addChild(IExecutionNode child) {
		childs += child
		testChilds()
	}

	override synchronized isEmpty() {
		return childs.empty
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		childs.clear
		testChilds()
	}

	def protected void testChilds() {
		for (check : childChecklist) {
			if (!check.test(childs)) {
				deactivate()
				return
			}
			if (!check.test(childs)) {
				deactivate()
				return
			}
		}
		activate()
	}

}