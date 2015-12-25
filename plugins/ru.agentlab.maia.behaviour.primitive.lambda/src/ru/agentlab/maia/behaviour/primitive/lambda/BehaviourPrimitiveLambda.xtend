package ru.agentlab.maia.behaviour.primitive.lambda

import ru.agentlab.maia.behaviour.BehaviourPrimitive

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveLambda extends BehaviourPrimitive implements IBehaviourPrimitiveLambda {

	var protected ILambda lambda

	override void setLambda(ILambda lambda) {
		this.lambda = lambda
		state = State.READY
	}

	override protected executeInternal(Object[] args) {
		return lambda.execute(args)
	}

}
