package ru.agentlab.maia.execution.task

import java.util.UUID
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Parameter implements IParameter {

	val String name

	val Class<?> type

	val Direction direction

	var String key

	new(String name, Class<?> type, Direction direction) {
		this.name = name
		this.type = type
		this.direction = direction
		if (direction == Direction.OUTPUT) {
			key = UUID.randomUUID.toString
		}
	}

}