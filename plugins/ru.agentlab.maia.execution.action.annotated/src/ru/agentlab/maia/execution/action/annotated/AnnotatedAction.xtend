package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.util.ArrayList
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.action.AbstractAction
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.execution.node.DataInputParameter
import ru.agentlab.maia.execution.node.DataOutputParameter
import ru.agentlab.maia.execution.tree.IDataInputParameter
import ru.agentlab.maia.execution.tree.IDataOutputParameter

class AnnotatedAction extends AbstractAction {

	val inputFields = new ArrayList<Field>

	val outputFields = new ArrayList<Field>

	var IMaiaContextInjector injector

	new(Class<?> clazz) {
		super(clazz)
		actionClass.declaredFields.filter[isAnnotationPresent(Input)].forEach [
			inputFields += it
			addInput(createInput(name, it))
		]
		actionClass.declaredFields.filter[isAnnotationPresent(Output)].forEach [
			outputFields += it
			addOutput(createOutput(name, it))
		]
		inputFields.trimToSize
		outputFields.trimToSize
	}
	
	def <T> IDataInputParameter<T> createInput(String name, Field field){
		val c = field.type as Class<T>
		new DataInputParameter(name, c)
	}
	
	def <T> IDataOutputParameter<T> createOutput(String name, Field field){
		val c = field.type as Class<T>
		new DataOutputParameter(name, c)
	}

	override doInject() {
		inputFields.forEach [
			val input = getInput(it.name)
			val value = context.get(input.key)
			accessible = true
			set(actionImpl, value)
		]
	}

	override doRun() {
		if (injector == null) {
			injector = context.get(IMaiaContextInjector)
		}
		return injector.invoke(actionImpl, Action)
	}

	override doUninject() {
		outputFields.forEach [
			val value = get(actionImpl)
			val output = getOutput(it.name)
			context.set(output.key, value)
		]
	}

}