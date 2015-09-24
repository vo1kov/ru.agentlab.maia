package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.IExecutionInput

class ExecutionInput<T> extends AbstractExecutionParameter<T> implements IExecutionInput<T> {

	new(String name, Class<T> type, boolean isOptional) {
		super(name, type, isOptional)
	}

	new(String name, Class<T> type) {
		super(name, type, false)
	}

	def synchronized dump() {
		val state = state.get
		val size = linked.size
		if (state.equals(LINKED) && size == 0) {
			println("Linked but empty list ")
		}
	}

}