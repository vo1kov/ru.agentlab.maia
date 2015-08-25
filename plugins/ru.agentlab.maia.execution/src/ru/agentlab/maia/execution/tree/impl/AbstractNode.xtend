package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode

abstract class AbstractNode implements IExecutionNode {

	val protected inputs = new ArrayList<IDataParameter>

	val protected outputs = new ArrayList<IDataParameter>

	@Inject
	protected IMaiaContext context

	override void addInput(IDataParameter input) {
		inputs += input
	}

	override removeInput(IDataParameter input) {
		inputs.remove(input)
	}

	override getInput(String name) {
		return inputs.findFirst[it.name == name]
	}

	override void addOutput(IDataParameter output) {
		outputs += output
	}

	override removeOutput(IDataParameter output) {
		outputs.remove(output)
	}

	override getOutput(String name) {
		return outputs.findFirst[it.name == name]
	}
}