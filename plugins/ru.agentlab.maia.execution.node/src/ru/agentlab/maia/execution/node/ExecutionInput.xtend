package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionInput

class ExecutionInput<T> extends AbstractExecutionParameter<T> implements IExecutionInput<T> {

	new(String name, Class<T> type, IExecutionNode node, boolean isOptional) {
		super(name, type, node, isOptional)
	}
	
	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override void changeStateConnected() {
		val old = state.getAndSet(CONNECTED)
		if (old != CONNECTED) {
			node.onInputConnected(this)
		}
	}

	override void changeStateDisconnected() {
		val old = state.getAndSet(DISCONNECTED)
		if (old != DISCONNECTED) {
			node.onInputDisconnected(this)
		}
	}

}