package ru.agentlab.maia.behaviour.primitive

import java.lang.reflect.Field
import java.lang.reflect.Method
import java.util.ArrayList
import ru.agentlab.maia.behaviour.annotation.Action
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output
import ru.agentlab.maia.behaviour.IBehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourPrimitive
import ru.agentlab.maia.behaviour.BehaviourState

class AnnotatedAction extends BehaviourPrimitive {

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
		state = BehaviourState.READY
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

	def private <T> IBehaviourParameter<T> createPrameter(String name, Field field) {
		val c = field.type as Class<T>
		new BehaviourParameter(name, c)
	}

	def private <T> save(IBehaviourParameter<T> output, Field field) {
		val value = field.get(implementation) as T
		output.value = value
	}

	override reset() {
	}

}