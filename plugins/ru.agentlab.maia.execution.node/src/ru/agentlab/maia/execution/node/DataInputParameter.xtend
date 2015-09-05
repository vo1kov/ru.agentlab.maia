package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.tree.IDataInputParameter

class DataInputParameter<T> extends AbstractParameter<T> implements IDataInputParameter<T> {

	new(String name, Class<T> type) {
		super(name, type)
	}

}