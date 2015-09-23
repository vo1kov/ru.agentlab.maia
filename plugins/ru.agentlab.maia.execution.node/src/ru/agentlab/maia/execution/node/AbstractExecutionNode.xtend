package ru.agentlab.maia.execution.node

import java.util.concurrent.CopyOnWriteArraySet
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import ru.agentlab.maia.execution.IExecutionInput
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionOutput
import ru.agentlab.maia.execution.IExecutionScheduler

abstract class AbstractExecutionNode implements IExecutionNode {

	val protected inputs = new CopyOnWriteArraySet<IExecutionInput<?>>

	val protected outputs = new CopyOnWriteArraySet<IExecutionOutput<?>>

	val protected parent = new AtomicReference<IExecutionScheduler>

	val protected state = new AtomicInteger(UNKNOWN)

	// --------------------------------------------
	// Parent manipulations
	// --------------------------------------------
	override setParent(IExecutionScheduler newParent) {
		parent.set(newParent)
	}

	override IExecutionScheduler getParent() {
		return parent.get
	}

	// --------------------------------------------
	// Inputs manipulations
	// --------------------------------------------
	override getInputs() {
		return inputs.iterator
	}

	override void addInput(IExecutionInput<?> input) {
		inputs += input
		if (input.isConnected) {
			onInputConnected(input)
		} else if (input.disconnected) {
			onInputDisconnected(input)
		}
	}

	override removeInput(IExecutionInput<?> input) {
		inputs.remove(input)
		onInputConnected(null)
	}

	override getInput(String name) {
		return inputs.iterator.findFirst[it.name == name]
	}

	override onInputDisconnected(IExecutionInput<?> input) {
		if (!input.optional) {
			changeStateUnknown(true)
		}
	}

	override onOutputConnected(IExecutionOutput<?> output) {
		for (in : outputs) {
			if (in.disconnected) {
				return
			}
		}
		changeStateReady(true)
	}

	// --------------------------------------------
	// Outputs manipulations
	// --------------------------------------------
	override getOutputs() {
		return outputs.iterator
	}

	override void addOutput(IExecutionOutput<?> output) {
		outputs += output
		if (output.isConnected) {
			onOutputConnected(output)
		} else if (output.disconnected) {
			onOutputDisconnected(output)
		}
	}

	override removeOutput(IExecutionOutput<?> output) {
		outputs.remove(output)
		onOutputConnected(null)
	}

	override getOutput(String name) {
		return outputs.iterator.findFirst[it.name == name]
	}

	override onInputConnected(IExecutionInput<?> input) {
		for (in : inputs) {
			if (in.disconnected) {
				return
			}
		}
		changeStateReady(true)
	}

	override onOutputDisconnected(IExecutionOutput<?> output) {
		if (!output.optional) {
			changeStateUnknown(true)
		}
	}

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override void changeStateUnknown(boolean propagate) {
		val old = state.getAndSet(UNKNOWN)
		if (propagate && old != UNKNOWN) {
			parent.get?.onChildUnknown(this)
		}
	}

	override void changeStateReady(boolean propagate) {
		val old = state.getAndSet(READY)
		if (propagate && old != READY) {
			parent.get?.onChildReady(this)

		}
	}

	override void changeStateInWork(boolean propagate) {
		val old = state.getAndSet(IN_WORK)
		if (propagate && old != IN_WORK) {
			parent.get?.onChildInWork(this)
		}
	}

	override void changeStateWaiting(boolean propagate) {
		val old = state.getAndSet(WAITING)
		if (propagate && old != WAITING) {
			parent.get?.onChildWaiting(this)
		}
	}

	override void changeStateFinished(boolean propagate) {
		val old = state.getAndSet(FINISHED)
		if (propagate && old != FINISHED) {
			parent.get?.onChildFinished(this)
		}
	}

	override void changeStateException(boolean propagate) {
		val old = state.getAndSet(EXCEPTION)
		if (propagate && old != EXCEPTION) {
			parent.get?.onChildException(this)
		}
	}

	override boolean isStateUnknown() {
		state.get == UNKNOWN
	}

	override boolean isStateReady() {
		state.get == READY
	}

	override boolean isStateInWork() {
		state.get == IN_WORK
	}

	override boolean isStateWaiting() {
		state.get == WAITING
	}

	override boolean isStateFinished() {
		state.get == FINISHED
	}

	override boolean isStateException() {
		state.get == EXCEPTION
	}
}