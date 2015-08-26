package ru.agentlab.maia.execution.tree.impl

import ru.agentlab.maia.execution.tree.IDataOutputParameter

class DataOutputParameter<T> extends AbstractParameter<T> implements IDataOutputParameter<T> {

	new(String name, Class<T> type) {
		super(name, type)
	}

}