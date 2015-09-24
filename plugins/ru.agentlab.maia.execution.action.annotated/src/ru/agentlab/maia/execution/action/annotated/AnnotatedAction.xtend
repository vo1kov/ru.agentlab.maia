package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.util.ArrayList
import javax.inject.Inject
import ru.agentlab.maia.execution.action.AbstractExecutionAction
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.execution.node.ExecutionInput
import ru.agentlab.maia.execution.IExecutionInput
import ru.agentlab.maia.execution.node.ExecutionOutput
import ru.agentlab.maia.execution.IExecutionOutput

class AnnotatedAction extends AbstractExecutionAction {

	var Field[] inputFields = newArrayOfSize(0)

	var Field[] outputFields = newArrayOfSize(0)

	@Inject
	var IMaiaContextInjector injector

	override setImplementation(Object impl) {
		super.implementation = impl
		val inputs = new ArrayList<Field>
		val outputs = new ArrayList<Field>
		for (field : implementation.get.class.declaredFields) {
			if (field.isAnnotationPresent(Input)) {
				inputs += field
				addInput(createInput(field.name, field))
			} else if (field.isAnnotationPresent(Output)) {
				outputs += field
				addOutput(createOutput(field.name, field))
			}
		}
		inputFields = inputs.toArray(newArrayOfSize(inputs.size))
		outputFields = outputs.toArray(newArrayOfSize(outputs.size))
	}

	override doInject() {
		for(i : 0..< inputFields.length){
			val input = inputs.get(i)
			inputFields.get(i).accessible = true
			inputFields.get(i).set(implementation, input.value)
		}
	}

	override doRun() {
		return injector.invoke(implementation, Action)
	}

	override doUninject() {
		for (field : outputFields) {
//			val output = getOutput(field.name)
//			for (linked : output.linked) {
//				linked.setParameter(field.get(implementation))
//			}
		}
	}

	def private <T> IExecutionInput<T> createInput(String name, Field field) {
		val c = field.type as Class<T>
		new ExecutionInput(name, c)
	}

	def private <T> IExecutionOutput<T> createOutput(String name, Field field) {
		val c = field.type as Class<T>
		new ExecutionOutput(name, c)
	}

}