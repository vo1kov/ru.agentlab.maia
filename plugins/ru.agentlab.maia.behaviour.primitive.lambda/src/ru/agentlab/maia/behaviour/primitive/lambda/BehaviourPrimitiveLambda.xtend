package ru.agentlab.maia.behaviour.primitive.lambda

import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourState
import ru.agentlab.maia.behaviour.IBehaviourPrimitive

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveLambda extends Behaviour implements IBehaviourPrimitive {

	var protected IExecutable executable

	def void setImplementation(IExecutable executable) {
		this.executable = executable
		state = BehaviourState.READY
	}

	override execute() throws Exception {
		try {
			val args = newArrayOfSize(inputs.length)
			inputs.forEach [ param, index |
				args.set(index, param.value)
			]
			val results = executable.execute(args)
			results.forEach [ obj, i |
				save(outputs.get(i), obj)
			]
			state = BehaviourState.SUCCESS
		} catch (Exception e) {
			state = BehaviourState.FAILED
			throw e
		}
	}

	def protected <T> save(BehaviourParameter<T> output, Object value) {
		output.value = value as T
	}

}
