package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.util.ArrayList
import javax.inject.Inject
import ru.agentlab.maia.execution.action.AbstractAction
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.execution.node.DataInputParameter
import ru.agentlab.maia.execution.node.DataOutputParameter
import ru.agentlab.maia.execution.tree.IDataInputParameter
import ru.agentlab.maia.execution.tree.IDataOutputParameter
import ru.agentlab.maia.memory.IMaiaContextInjector

class AnnotatedAction extends AbstractAction {

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
		for (field : inputFields) {
			val input = getInput(field.name)
			field.accessible = true
			field.set(implementation, input.value)
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

//	def private <T> setParameter(IDataParameter<T> param, Object value) {
//		param.value = value as T
//	}
	def private <T> IDataInputParameter<T> createInput(String name, Field field) {
		val c = field.type as Class<T>
		new DataInputParameter(name, c)
	}

	def private <T> IDataOutputParameter<T> createOutput(String name, Field field) {
		val c = field.type as Class<T>
		new DataOutputParameter(name, c)
	}

}