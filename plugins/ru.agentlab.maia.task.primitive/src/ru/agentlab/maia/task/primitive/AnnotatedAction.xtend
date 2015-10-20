package ru.agentlab.maia.task.primitive

import java.lang.reflect.Field
import java.lang.reflect.Method
import java.util.ArrayList
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.PrimitiveTask
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.annotation.Action
import ru.agentlab.maia.task.annotation.Input
import ru.agentlab.maia.task.annotation.Output

class AnnotatedAction extends PrimitiveTask {

	var Field[] inputFields = newArrayOfSize(0)

	var Field[] outputFields = newArrayOfSize(0)

	val Method method

	new(Object impl) {
		implementation.set = impl
		val inputs = new ArrayList<Field>
		val outputs = new ArrayList<Field>
		for (field : impl.class.declaredFields) {
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
		method = impl.class.declaredMethods.findFirst[isAnnotationPresent(Action)]
		if (method == null) {
			throw new IllegalStateException("Task have no method annotated with @Actions")
		}
		state = State.READY
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
		method.invoke(implementation.get)
	}

	override protected doUninject() {
		for (i : 0 ..< outputFields.length) {
			val output = outputs.get(i)
			val field = outputFields.get(i)
			save(output, field)
		}
	}

	def private <T> ITaskParameter<T> createPrameter(String name, Field field) {
		val c = field.type as Class<T>
		new TaskParameter(name, c)
	}

	def private <T> save(ITaskParameter<T> output, Field field) {
		val value = field.get(implementation) as T
		output.value = value
	}

	override reset() {
	}

}