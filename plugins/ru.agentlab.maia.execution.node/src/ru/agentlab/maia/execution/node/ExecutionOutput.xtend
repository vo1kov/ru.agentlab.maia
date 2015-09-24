package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.IExecutionOutput

class ExecutionOutput<T> extends AbstractExecutionParameter<T> implements IExecutionOutput<T> {

	new(String name, Class<T> type, boolean isOptional) {
		super(name, type, isOptional)
	}

	new(String name, Class<T> type) {
		super(name, type, false)
	}

}