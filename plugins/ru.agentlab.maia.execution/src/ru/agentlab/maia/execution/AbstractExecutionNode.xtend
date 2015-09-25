package ru.agentlab.maia.execution

import java.util.concurrent.CopyOnWriteArrayList

abstract class AbstractExecutionNode implements IExecutionNode {

	val protected inputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	val protected outputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	override getInputs() {
		return inputs
	}

	override void addInput(IExecutionParameter<?> input) {
		inputs += input
	}

	override removeInput(IExecutionParameter<?> input) {
		inputs -= input
	}

	override getOutputs() {
		return outputs
	}

	override void addOutput(IExecutionParameter<?> output) {
		outputs += output
	}

	override removeOutput(IExecutionParameter<?> output) {
		outputs -= output
	}

}