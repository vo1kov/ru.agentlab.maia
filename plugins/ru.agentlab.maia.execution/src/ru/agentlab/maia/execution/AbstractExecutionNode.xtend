package ru.agentlab.maia.execution

import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractExecutionNode implements IExecutionNode {

	@Accessors
	val protected inputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	@Accessors
	val protected outputs = new CopyOnWriteArrayList<IExecutionParameter<?>>

	val protected parent = new AtomicReference<IExecutionScheduler>

	@Accessors
	var protected State state = State.UNKNOWN

	override setParent(IExecutionScheduler newParent) {
		val oldParent = parent.getAndSet(newParent)
		if (oldParent != newParent) {
			oldParent.removeChild(this)
		}
	}

	override IExecutionScheduler getParent() {
		return parent.get
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