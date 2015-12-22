package ru.agentlab.maia.behaviour.primitive

import java.lang.reflect.Field
import java.lang.reflect.Method
import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourException
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourState
import ru.agentlab.maia.behaviour.annotation.Execute
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitive extends Behaviour implements IBehaviourPrimitive {

	val List<Pair<Field, BehaviourParameter<?>>> inputFieldMapping = new ArrayList

	val List<Pair<Field, BehaviourParameter<?>>> outputFieldMapping = new ArrayList

	val BehaviourParameter<?>[] inputMethodMapping

	val BehaviourParameter<?> outputMethodMapping

	val Method method

	val Object implementation

	new(Object impl) {
		this.implementation = impl

		implementation.class.declaredFields.forEach [ field |
			if (field.isAnnotationPresent(Input)) {
				val param = new BehaviourParameter(field.name, field.type)
				this.addInput(param)
				inputFieldMapping += (field -> param)
			} else if (field.isAnnotationPresent(Output)) {
				val param = new BehaviourParameter(field.name, field.type)
				this.addOutput(param)
				outputFieldMapping += (field -> param)
			}
		]

		method = impl.class.declaredMethods.findFirst[isAnnotationPresent(Execute)]
		if (method == null) {
			throw new IllegalStateException("Task have no method annotated with @" + Execute.simpleName)
		}
		if (method.isAnnotationPresent(Input)) {
			val BehaviourParameter<?>[] result = newArrayOfSize(method.parameterCount)
			method.parameters.forEach [ parameter, index |
				val param = new BehaviourParameter(parameter.name, parameter.type)
				this.addInput(param)
				result.set(index, param)
			]
			inputMethodMapping = result
		} else {
			inputMethodMapping = null
		}
		if (method.isAnnotationPresent(Output)) {
			val param = new BehaviourParameter(method.name, method.returnType)
			this.addOutput(param)
			outputMethodMapping = param
		} else {
			outputMethodMapping = null
		}
		method.exceptionTypes.forEach [
			val exc = new BehaviourException(it)
			this.addException(exc)
		]
		state = BehaviourState.READY
	}

	override execute() throws Exception {
		try {
			injectFields()
			val args = newArrayOfSize(inputMethodMapping.length)
			inputMethodMapping.forEach [ param, index |
				args.set(index, param.value)
			]
			val result = method.invoke(implementation, args)
			uninjectFields()
			uninjectMethod(result)
			state = BehaviourState.SUCCESS
		} catch (Exception e) {
			state = BehaviourState.FAILED
			throw e
		}
	}

	/**
	 *  Inject behavior parameters to field values
	 */
	protected def void injectFields() {
		inputFieldMapping.forEach [ pair |
			val field = pair.key
			val param = pair.value
			field.set(implementation, param.value)
		]
	}

	/**
	 * UnInject field values to behavior parameters
	 */
	protected def void uninjectFields() {
		outputFieldMapping.forEach [ pair |
			val field = pair.key
			val param = pair.value
			save(param, field.get(implementation))
		]
	}

	/**
	 * UnInject method result value to behavior parameters
	 */
	protected def void uninjectMethod(Object result) {
		if (outputMethodMapping !== null) {
			save(outputMethodMapping, result)
		}
	}

	def private <T> save(BehaviourParameter<T> output, Object value) {
		output.value = value as T
	}

}
