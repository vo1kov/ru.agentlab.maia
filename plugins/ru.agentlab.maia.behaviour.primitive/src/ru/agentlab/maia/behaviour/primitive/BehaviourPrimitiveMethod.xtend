package ru.agentlab.maia.behaviour.primitive

import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourState

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveMethod extends BehaviourPrimitiveReflection {

	override setImplementation(Object impl) {
		super.setImplementation(impl)
		method.parameterTypes.forEach [ param, index |
			addInput(new BehaviourParameter('''arg«index»''', param))
		]
		if (!method.returnType.equals(Void.TYPE)) {
			addOutput(new BehaviourParameter(method.name, method.returnType))
		}
		state = BehaviourState.READY
	}

	override protected executeInternal(Object[] args) {
		return #[method.invoke(implementation, args)]
	}

}
