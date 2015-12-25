package ru.agentlab.maia.behaviour

abstract class BehaviourPrimitive extends Behaviour implements IBehaviourPrimitive {

	override final execute() throws java.lang.Exception {
		try {
			val args = newArrayOfSize(inputs.length)
			inputs.forEach [ param, index |
				args.set(index, param.value)
			]
			val results = executeInternal(args)
			results.forEach [ obj, i |
				save(outputs.get(i), obj)
			]
			state = State.SUCCESS
		} catch (java.lang.Exception e) {
			state = State.FAILED
			throw e
		}
	}

	def private <T> save(Parameter<T> output, Object value) {
		output.value = value as T
	}

	def protected Object[] executeInternal(Object[] args)

}