package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.check.IChildsCheck
import ru.agentlab.maia.execution.tree.IDataLink
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

@Accessors(PUBLIC_GETTER)
abstract class AbstractScheduler extends AbstractNode implements IExecutionScheduler {

	val protected dataLinks = new ArrayList<IDataLink>

	val protected childs = new ArrayList<IExecutionNode>

	val protected childChecklist = new ArrayList<IChildsCheck>

	var protected IExecutionNode currentChild

	override run() {
		nextChild?.run
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
		dataLinks += new DataLink(from, to)
	}

	override synchronized void addChild(IExecutionNode child) {
		if (!childs.contains(child)) {
			childs += child
			testChilds()
		}
	}

	override synchronized isEmpty() {
		return childs.empty
	}

	/** 
	 * Removes all nodes from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 */
	override synchronized void removeAll() {
		childs.clear
		testChilds()
	}

	/** 
	 * Removes specified node from the queue.
	 * That method have side effect - after method execution
	 * state of this node can change. It depends of checklist.
	 * 
	 * @param node - node to be deleted
	 */
	override synchronized removeChild(IExecutionNode node) {
		childs -= node
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

	override synchronized IExecutionNode getCurrentChild() {
		return currentChild
	}

}