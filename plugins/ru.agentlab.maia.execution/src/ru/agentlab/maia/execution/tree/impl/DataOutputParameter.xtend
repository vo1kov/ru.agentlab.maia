package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.tree.IDataOutputParameter
import ru.agentlab.maia.execution.tree.IDataParameter

class DataOutputParameter<T> extends AbstractParameter<T> implements IDataOutputParameter<T> {

	val List<IDataParameter<T>> linked = new ArrayList

	new(String name, Class<T> type) {
		super(name, type)
	}

	def void add(IDataParameter<T> param) {
		linked += param
	}

	def void doSome() {
		linked.forEach [ param |
			param.value = this.value
		]
	}

}