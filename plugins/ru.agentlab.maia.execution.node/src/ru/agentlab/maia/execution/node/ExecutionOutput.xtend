package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionOutput

class ExecutionOutput<T> extends AbstractExecutionParameter<T> implements IExecutionOutput<T> {

	new(String name, Class<T> type, IExecutionNode node, boolean isOptional) {
		super(name, type, node, isOptional)
	}

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override void changeStateConnected() {
		val old = state.getAndSet(CONNECTED)
		if (old != CONNECTED) {
			node.onOutputConnected(this)
		}
	}

	override void changeStateDisconnected() {
		val old = state.getAndSet(DISCONNECTED)
		if (old != DISCONNECTED) {
			node.onOutputDisconnected(this)
		}
	}

}