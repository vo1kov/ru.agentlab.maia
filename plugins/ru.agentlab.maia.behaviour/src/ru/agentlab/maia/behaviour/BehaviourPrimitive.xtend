package ru.agentlab.maia.behaviour

abstract class BehaviourPrimitive extends Behaviour implements IBehaviourPrimitive {

	override final execute() throws Exception {
		try {
			val args = newArrayOfSize(inputs.length)
			inputs.forEach [ param, index |
				args.set(index, param.value)
			]
			val results = executeInternal(args)
			results.forEach [ obj, i |
				save(outputs.get(i), obj)
			]
			state = BehaviourState.SUCCESS
		} catch (Exception e) {
			state = BehaviourState.FAILED
			throw e
		}
	}

	def private <T> save(BehaviourParameter<T> output, Object value) {
		output.value = value as T
	}

	def protected Object[] executeInternal(Object[] args)

}