package ru.agentlab.maia.execution.tree.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IDataParameter

@Accessors
abstract class AbstractParameter implements IDataParameter {

	val String name

	val Class<?> type

	var String key

	new(String name, Class<?> type) {
		this.name = name
		this.type = type
	}

}