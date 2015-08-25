package ru.agentlab.maia.execution.tree.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IDataParameter

@Accessors
class DataParameter implements IDataParameter {

	val String name

	val Class<?> type

	val Direction direction

	var String key

	new(String name, Class<?> type, Direction direction) {
		this.name = name
		this.type = type
		this.direction = direction
//		if (direction == Direction.OUTPUT) {
//			key = UUID.randomUUID.toString
//		}
	}

}