package ru.agentlab.maia.execution.node

import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.CopyOnWriteArraySet
import java.util.concurrent.atomic.AtomicReference
import ru.agentlab.maia.execution.IExecutionInput
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionOutput
import ru.agentlab.maia.execution.IExecutionParameter
import ru.agentlab.maia.execution.IStateChangedListener

abstract class AbstractExecutionNode implements IExecutionNode, IStateChangedListener<IExecutionParameter<?>> {

	val protected inputs = new CopyOnWriteArrayList<IExecutionInput<?>>

	val protected outputs = new CopyOnWriteArrayList<IExecutionOutput<?>>

	val protected listeners = new CopyOnWriteArraySet<IStateChangedListener<IExecutionNode>>

	val protected state = new AtomicReference<String>(READY)

	// --------------------------------------------
	// Inputs manipulations
	// --------------------------------------------
	override getInputs() {
		return inputs
	}

	override void addInput(IExecutionInput<?> input) {
		inputs += input
		onStateChanged(input, null, input.state)
	}

	override removeInput(IExecutionInput<?> input) {
		inputs.remove(input)
		onStateChanged(input, input.state, IExecutionParameter.LINKED)
	}

	// --------------------------------------------
	// Outputs manipulations
	// --------------------------------------------
	override getOutputs() {
		return outputs
	}

	override void addOutput(IExecutionOutput<?> output) {
		outputs += output
		onStateChanged(output, null, output.state)
	}

	override removeOutput(IExecutionOutput<?> output) {
		outputs.remove(output)
		onStateChanged(output, output.state, IExecutionParameter.LINKED)
	}

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override String getState() {
		return state.get
	}

	override setState(String newState) {
		val oldState = state.getAndSet(newState)
		if (oldState != newState) {
			listeners.forEach [
				onStateChanged(this, oldState, newState)
			]
		}
		return oldState
	}

	override addStateListener(IStateChangedListener<IExecutionNode> listener) {
		listeners += listener
	}

	override removeStateListener(IStateChangedListener<IExecutionNode> listener) {
		listeners -= listener
	}

	override onStateChanged(IExecutionParameter<?> param, String oldState, String newState) {
		switch (newState) {
			case IExecutionParameter.LINKED: {
			}
			case IExecutionParameter.UNLINKED: {
				if (!param.optional) {
					state = UNKNOWN
				}
			}
			default: {
				throw new IllegalStateException("Unknown parameter state - [" + newState + "]")
			}
		}
	}

}