package ru.agentlab.maia.execution.node

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.tree.IDataOutputParameter
import ru.agentlab.maia.execution.tree.IDataParameter

class DataOutputParameter<T> extends AbstractParameter<T> implements IDataOutputParameter<T> {

	val List<IDataParameter<T>> linked = new ArrayList

	new(String name, Class<T> type) {
		super(name, type)
	}

	override void addLinked(IDataParameter<T> param) {
		linked += param
	}

	override getLinked() {
		return linked
	}

}