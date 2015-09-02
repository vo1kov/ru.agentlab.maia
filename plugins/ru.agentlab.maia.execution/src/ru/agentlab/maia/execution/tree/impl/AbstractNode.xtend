package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.check.IParametersCheck
import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IDataInputParameter
import ru.agentlab.maia.execution.tree.IDataOutputParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

@Accessors(PUBLIC_GETTER)
abstract class AbstractNode implements IExecutionNode {

	val protected inputs = new ArrayList<IDataInputParameter<?>>

	val protected outputs = new ArrayList<IDataOutputParameter<?>>

	val protected parametersChecklist = new ArrayList<IParametersCheck>

	@Inject
	IMaiaContext context

	IExecutionScheduler parent

	ExecutionNodeState state = ExecutionNodeState.UNKNOWN

	@PostConstruct
	def void init() {
		val parentContext = context.parent
		if (parentContext != null) {
			parent = parentContext.get(IExecutionNode) as IExecutionScheduler
			if (parent != null) {
				parent.addChild(this)
			}
		}
		state = ExecutionNodeState.INSTALLED
	}

	@PreDestroy
	def void destroy() {
		if (parent != null) {
			parent.removeChild(this)
		}
		state = ExecutionNodeState.UNKNOWN
	}

	override void block() {
		if (state != ExecutionNodeState.BLOCKED) {
			state = ExecutionNodeState.BLOCKED
			parent?.notifyChildDeactivation(this)
		}
	}

	override void activate() {
		if (state != ExecutionNodeState.ACTIVE) {
			state = ExecutionNodeState.ACTIVE
			parent?.notifyChildActivation(this)
		}
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

	override synchronized void addInput(IDataInputParameter<?> input) {
		inputs += input
		testPatameters()
	}

	override synchronized removeInput(IDataInputParameter<?> input) {
		inputs.remove(input)
		testPatameters()
	}

	override synchronized getInput(String name) {
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

	override synchronized getInputs() {
		return inputs
	}

	override synchronized getOutputs() {
		return outputs
	}

}