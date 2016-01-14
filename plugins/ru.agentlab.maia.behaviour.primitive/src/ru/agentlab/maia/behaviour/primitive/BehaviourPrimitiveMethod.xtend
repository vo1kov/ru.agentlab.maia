package ru.agentlab.maia.behaviour.primitive

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveMethod extends BehaviourPrimitiveReflection {

	override setImplementation(Object impl) {
		super.setImplementation(impl)
		method.parameterTypes.forEach [ param, index |
			addInput(new Parameter('''arg«index»''', param))
		]
		if (!method.returnType.equals(Void.TYPE)) {
			addOutput(new Parameter(method.name, method.returnType))
		}
		state = State.READY
	}

	override protected executeInternal(Object[] args) {
		return #[method.invoke(implementation, args)]
	}
	
}
