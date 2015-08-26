package ru.agentlab.maia.execution.tree.impl

import ru.agentlab.maia.execution.tree.IDataOutputParameter

class DataOutputParameter extends AbstractParameter implements IDataOutputParameter {
	
	new(String name, Class<?> type) {
		super(name, type)
	}
	
}