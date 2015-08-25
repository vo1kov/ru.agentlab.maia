package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import java.util.List
import java.util.concurrent.CopyOnWriteArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IDataLink
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

abstract class AbstractScheduler extends AbstractNode implements IExecutionScheduler {

	@Accessors
	val List<IDataLink> links = new ArrayList

	@Accessors
	val List<IExecutionNode> childs = new CopyOnWriteArrayList

	val Object lock = new Object

	override run() {
		var IExecutionNode node
		synchronized (lock) {
			node = next
		}
		node.run
	}

	def void addLink(IDataParameter from, IDataParameter to) {
		if (from.key != null && from.key.length > 0) {
			to.key = from.key
		}
		links += new DataLink(from, to)
	}

	def void addChild(IExecutionNode child) {
		childs += child
	}

}