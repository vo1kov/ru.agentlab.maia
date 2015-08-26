package ru.agentlab.maia.execution.tree.impl

import ru.agentlab.maia.execution.tree.IDataInputParameter

class DataInputParameter extends AbstractParameter implements IDataInputParameter {

	new(String name, Class<?> type) {
		super(name, type)
	}

}