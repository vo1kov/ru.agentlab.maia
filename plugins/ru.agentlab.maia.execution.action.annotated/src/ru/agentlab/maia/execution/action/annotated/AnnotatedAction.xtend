package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.util.ArrayList
import javax.inject.Inject
import ru.agentlab.maia.execution.AbstractExecutionAction
import ru.agentlab.maia.execution.ExecutionParameter
import ru.agentlab.maia.execution.IExecutionParameter
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.memory.IMaiaContextInjector

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
				addInput(createPrameter(field.name, field))
			} else if (field.isAnnotationPresent(Output)) {
				outputs += field
				addOutput(createPrameter(field.name, field))
			}
		}
		inputFields = inputs.toArray(newArrayOfSize(inputs.size))
		outputFields = outputs.toArray(newArrayOfSize(outputs.size))
	}

	override reset() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override protected doInject() {
		for (i : 0 ..< inputFields.length) {
			val input = inputs.get(i)
			val field = inputFields.get(i)
			field.accessible = true
			field.set(implementation, input.value)
		}
	}

	override protected doRun() {
		return injector.invoke(implementation, Action)
	}

	override protected doUninject() {
		for (i : 0 ..< outputFields.length) {
			val output = outputs.get(i)
			val field = outputFields.get(i)
			save(output, field)
		}
	}

	def private <T> IExecutionParameter<T> createPrameter(String name, Field field) {
		val c = field.type as Class<T>
		new ExecutionParameter(name, c)
	}

	def private <T> save(IExecutionParameter<T> output, Field field) {
		val value = field.get(implementation) as T
		output.value = value
	}

}