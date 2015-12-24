package ru.agentlab.maia.behaviour.primitive

import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.BehaviourState

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveMethod extends BehaviourPrimitive {

	override setImplementation(Object impl) {
		super.setImplementation(impl)
		method.parameters.forEach [
			addInput(new BehaviourParameter(name, type))
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
