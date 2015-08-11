package ru.agentlab.maia.execution.task

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractScheduler extends AbstractNode implements IScheduler {

	@Accessors
	val List<Link> links = new ArrayList

	override run() {
		next.run
	}

	def void addLink(IParameter from, IParameter to) {
		if (from.key != null && from.key.length > 0) {
			to.key = from.key
		}
		links += new Link(from, to)
	}

}