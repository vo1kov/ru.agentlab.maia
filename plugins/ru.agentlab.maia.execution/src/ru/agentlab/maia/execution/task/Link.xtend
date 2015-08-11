package ru.agentlab.maia.execution.task

import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.task.IParameter.Direction

@Accessors
class Link {

	IParameter from

	IParameter to

	String key

	new(IParameter from, IParameter to) {
		this.from = from
		this.to = to
		if (from.direction == Direction.INPUT) {
		}
		key = UUID.randomUUID.toString
	}
}