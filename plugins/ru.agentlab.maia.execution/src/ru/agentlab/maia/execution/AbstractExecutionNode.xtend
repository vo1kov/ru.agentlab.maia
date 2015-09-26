package ru.agentlab.maia.execution

import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference

abstract class AbstractExecutionNode implements IExecutionNode {

	val protected inputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	val protected outputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	val protected parent = new AtomicReference<IExecutionScheduler>

	val protected state = new AtomicInteger(UNKNOWN)
	
	override getState() {
		return state.get
	}

	override setParent(IExecutionScheduler newParent) {
		parent.set(newParent)
	}

	override IExecutionScheduler getParent() {
		return parent.get
	}

	override getInputs() {
		return inputs
	}

	override void addInput(IExecutionParameter<?> input) {
		inputs += input
	}

	override removeInput(IExecutionParameter<?> input) {
		inputs -= input
	}

	override removeAllInputs() {
		inputs.clear
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

	override removeAllOutputs() {
		outputs.clear
	}

}