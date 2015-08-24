package ru.agentlab.maia.execution.task

import java.util.ArrayList
import java.util.List
import java.util.concurrent.CopyOnWriteArrayList
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractScheduler extends AbstractNode implements IScheduler {

	@Accessors
	val List<Link> links = new ArrayList

	@Accessors
	val List<INode> childs = new CopyOnWriteArrayList

	val Object lock = new Object

	override run() {
		var INode node
		synchronized (lock) {
			node = next
		}
		node.run
	}

	def void addLink(IParameter from, IParameter to) {
		if (from.key != null && from.key.length > 0) {
			to.key = from.key
		}
		links += new Link(from, to)
	}

	def void addChild(INode child) {
		childs += child
	}

}