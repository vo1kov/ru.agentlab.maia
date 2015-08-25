package ru.agentlab.maia.execution.tree.impl

import java.util.ArrayList
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.check.IParametersCheck
import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IDataParameter
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

abstract class AbstractNode implements IExecutionNode {

	val protected inputs = new ArrayList<IDataParameter>

	val protected outputs = new ArrayList<IDataParameter>

	val protected dataChecklist = new ArrayList<IParametersCheck>

	@Inject
	protected IMaiaContext context

	@Accessors(AccessorType.PUBLIC_GETTER)
	IExecutionScheduler parent

	@Accessors(AccessorType.PUBLIC_GETTER)
	ExecutionNodeState state = ExecutionNodeState.UNKNOWN

	@PostConstruct
	def void init() {
		parent = context.parent.get(IExecutionNode) as IExecutionScheduler
		if (parent != null) {
			parent.addChild(this)
		}
		state = ExecutionNodeState.ADDED
	}

	@PreDestroy
	def void destroy() {
		if (parent != null) {
			parent.removeChild(this)
		}
		state = ExecutionNodeState.DELETED
	}

	def protected void deactivate() {
		if (state != ExecutionNodeState.INACTIVE) {
			state = ExecutionNodeState.INACTIVE
			parent?.notifyChildDeactivation(this)
		}
	}

	def protected void activate() {
		if (state != ExecutionNodeState.ACTIVE) {
			state = ExecutionNodeState.ACTIVE
			parent?.notifyChildActivation(this)
		}
	}

	def private void testPatameters() {
		for (check : dataChecklist) {
			if (!check.test(inputs)) {
				deactivate()
				return
			}
			if (!check.test(outputs)) {
				deactivate()
				return
			}
		}
		activate()
	}

	override synchronized void addInput(IDataParameter input) {
		inputs += input
		testPatameters()
	}

	override synchronized removeInput(IDataParameter input) {
		inputs.remove(input)
		testPatameters()
	}

	override synchronized getInput(String name) {
		return inputs.findFirst[it.name == name]
	}

	override synchronized void addOutput(IDataParameter output) {
		outputs += output
		testPatameters()
	}

	override synchronized removeOutput(IDataParameter output) {
		outputs.remove(output)
		testPatameters()
	}

	override synchronized getOutput(String name) {
		return outputs.findFirst[it.name == name]
	}

	override toString() {
		class.simpleName + " [" + state + "]"
	}

}