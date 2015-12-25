package ru.agentlab.maia.behaviour.primitive.lambda

import ru.agentlab.maia.behaviour.BehaviourPrimitive
import ru.agentlab.maia.behaviour.BehaviourState

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourPrimitiveLambda extends BehaviourPrimitive implements IBehaviourPrimitiveLambda {

	var protected ILambda lambda

	override void setLambda(ILambda lambda) {
		this.lambda = lambda
		state = BehaviourState.READY
	}

	override protected executeInternal(Object[] args) {
		return lambda.execute(args)
	}

}
