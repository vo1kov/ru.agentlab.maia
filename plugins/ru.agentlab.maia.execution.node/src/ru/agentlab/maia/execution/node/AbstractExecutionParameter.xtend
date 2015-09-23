package ru.agentlab.maia.execution.node

import java.util.concurrent.CopyOnWriteArraySet
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.IExecutionInput
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionOutput
import ru.agentlab.maia.execution.IExecutionParameter

@Accessors
abstract class AbstractExecutionParameter<T> implements IExecutionParameter<T> {

	val String name

	val Class<T> type

	val IExecutionNode node

	val state = new AtomicInteger(DISCONNECTED)

	val protected linkedInputs = new CopyOnWriteArraySet<IExecutionInput<T>>

	val protected linkedOutputs = new CopyOnWriteArraySet<IExecutionOutput<T>>

	var AtomicReference<T> value

	val boolean isOptional

	new(String name, Class<T> type, IExecutionNode node, boolean isOptional) {
		this.name = name
		this.type = type
		this.node = node
		this.isOptional = isOptional
	}

	// --------------------------------------------
	// Value manipulations
	// --------------------------------------------
	override setValue(T v) {
		value.set(v)
	}

	override getValue() {
		value.get
	}

	// --------------------------------------------
	// Connection manipulations
	// --------------------------------------------
	override connect(IExecutionInput<T> input) {
		linkedInputs += input
		changeStateConnected
	}

	override connect(IExecutionOutput<T> output) {
		linkedOutputs += output
		changeStateConnected
	}

	override disconnect(IExecutionInput<T> input) {
		linkedInputs -= input
		if (linkedOutputs.empty && linkedInputs.empty) {
			changeStateDisconnected
		}
	}

	override disconnect(IExecutionOutput<T> output) {
		linkedOutputs -= output
		if (linkedOutputs.empty && linkedInputs.empty) {
			changeStateDisconnected
		}
	}

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override boolean isConnected() {
		return state.get == CONNECTED
	}

	override boolean isDisconnected() {
		state.get == DISCONNECTED
	}

}