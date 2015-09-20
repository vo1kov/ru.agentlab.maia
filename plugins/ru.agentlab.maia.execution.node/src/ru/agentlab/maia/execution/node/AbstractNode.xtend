package ru.agentlab.maia.execution.node

import java.util.concurrent.CopyOnWriteArraySet
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.check.IParametersCheck
import ru.agentlab.maia.execution.tree.IDataInputParameter
import ru.agentlab.maia.execution.tree.IDataOutputParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

abstract class AbstractNode implements IExecutionNode {

	@Accessors
	val protected inputs = new CopyOnWriteArraySet<IDataInputParameter<?>>

	@Accessors
	val protected outputs = new CopyOnWriteArraySet<IDataOutputParameter<?>>

	@Accessors
	val protected parametersChecklist = new CopyOnWriteArraySet<IParametersCheck>

	val protected parent = new AtomicReference<IExecutionScheduler>

	val protected state = new AtomicInteger(UNKNOWN)

	override void block() {
		val previous = state.getAndSet(WAITING)
		if (previous != WAITING) {
			parent.get?.notifyChildActivation(this)
		}
	}

	override void activate() {
		val previous = state.getAndSet(IN_WORK)
		if (previous != IN_WORK) {
			parent.get?.notifyChildActivation(this)
		}
	}

	override setParent(IExecutionScheduler newParent) {
		parent.set(newParent)
	}

	override IExecutionScheduler getParent() {
		return parent.get
	}

	def protected void testPatameters() {
		for (check : parametersChecklist) {
			if (!check.test(inputs)) {
				block()
				return
			}
			if (!check.test(outputs)) {
				block()
				return
			}
		}
		activate()
	}

	override void addInput(IDataInputParameter<?> input) {
		inputs += input
		testPatameters()
	}

	override removeInput(IDataInputParameter<?> input) {
		inputs.remove(input)
		testPatameters()
	}

	override getInput(String name) {
		return inputs.findFirst[it.name == name]
	}

	override synchronized void addOutput(IDataOutputParameter<?> output) {
		outputs += output
		testPatameters()
	}

	override synchronized removeOutput(IDataOutputParameter<?> output) {
		outputs.remove(output)
		testPatameters()
	}

	override synchronized getOutput(String name) {
		return outputs.findFirst[it.name == name]
	}

	override synchronized toString() {
		class.simpleName + " [" + state + "]"
	}

	override int getState() {
		return state.get
	}

}