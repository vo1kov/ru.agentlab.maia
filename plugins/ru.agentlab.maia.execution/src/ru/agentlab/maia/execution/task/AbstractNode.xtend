package ru.agentlab.maia.execution.task

import java.util.ArrayList
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

abstract class AbstractNode implements INode {

	val protected inputs = new ArrayList<IParameter>

	val protected outputs = new ArrayList<IParameter>
	
	@Inject
	protected IMaiaContext context

	override void addInput(IParameter input) {
		inputs += input
	}

	override removeInput(IParameter input) {
		inputs.remove(input)
	}
	
	override getInput(String name){
		return inputs.findFirst[it.name == name]
	}

	override void addOutput(IParameter output) {
		outputs += output
	}

	override removeOutput(IParameter output) {
		outputs.remove(output)
	}
	
	override getOutput(String name){
		return outputs.findFirst[it.name == name]
	}
}