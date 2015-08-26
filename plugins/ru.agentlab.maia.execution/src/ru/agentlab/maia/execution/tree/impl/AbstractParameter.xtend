package ru.agentlab.maia.execution.tree.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IDataParameter

@Accessors
abstract class AbstractParameter<T> implements IDataParameter<T> {

	val String name

	val Class<T> type

	var String key
	
	var T value

	new(String name, Class<T> type) {
		this.name = name
		this.type = type
	}

}