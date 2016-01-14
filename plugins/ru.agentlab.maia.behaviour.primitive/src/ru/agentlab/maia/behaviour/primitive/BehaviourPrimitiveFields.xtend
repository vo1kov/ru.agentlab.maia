package ru.agentlab.maia.behaviour.primitive

import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveFields extends BehaviourPrimitiveReflection {

	override setImplementation(Object impl) {
		super.setImplementation(impl)
		implementation.class.declaredFields.forEach [
			if (isAnnotationPresent(Input)) {
				addInput(new Parameter(name, type))
			} else if (isAnnotationPresent(Output)) {
				addOutput(new Parameter(name, type))
			}
		]
		state = State.READY
	}

	override protected executeInternal(Object[] args) {
		injectValues(args)
		method.invoke(implementation)
		return uninjectValues()
	}

	/**
	 *  Inject behavior parameters to field values
	 */
	def private void injectValues(Object[] args) {
		var i = 0
		for (field : implementation.class.declaredFields) {
			if (field.isAnnotationPresent(Input)) {
				field.set(implementation, args.get(i))
				i++
			}
		}
	}

	/**
	 * UnInject field values to behavior parameters
	 */
	def private Object[] uninjectValues() {
		val Object[] result = newArrayOfSize(outputs.size)
		var i = 0
		for (field : implementation.class.declaredFields) {
			if (field.isAnnotationPresent(Output)) {
				result.set(i, field.get(implementation))
				i++
			}
		}
		return result
	}
	
}
