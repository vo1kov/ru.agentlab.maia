package ru.agentlab.maia.execution.action.annotated

import java.lang.reflect.Field
import java.util.ArrayList
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.execution.task.AbstractAction
import ru.agentlab.maia.execution.task.IParameter.Direction
import ru.agentlab.maia.execution.task.Parameter

class AnnotatedAction extends AbstractAction {

	val inputFields = new ArrayList<Field>

	val outputFields = new ArrayList<Field>

	var IMaiaContextInjector injector

	new(Class<?> clazz) {
		super(clazz)
		actionClass.declaredFields.filter[isAnnotationPresent(Input)].forEach [
			inputFields += it
			addInput(new Parameter(name, type, Direction.INPUT))
		]
		actionClass.declaredFields.filter[isAnnotationPresent(Output)].forEach [
			outputFields += it
			addOutput(new Parameter(name, type, Direction.OUTPUT))
		]
		inputFields.trimToSize
		outputFields.trimToSize
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