package ru.agentlab.maia.execution.scheduler.scheme.internal

import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.IScheduler
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingScheme
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingStateMapping

class SchemeScheduler implements IScheduler {

	@Inject
	IMaiaContext context

	@Inject
	ISchedulingScheme scheme

	@Inject
	ISchedulingStateMapping stateMapping

	override getNextContext() {
		val currentResult = context.get(IMaiaContextAction.KEY_RESULT)
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	def IMaiaContextAction getNextAction(IMaiaContext context) {
		// test current context have action
		val action = context.get(IMaiaContextAction)
		if (action != null) {
			return action
		} else {
			val scheme = context.get(ISchedulingScheme)
			val mapping = context.get(ISchedulingStateMapping)
			synchronized (scheme) {
				synchronized (mapping) {
				}
			}
			val currentResult = if (mapping != null) {
					val currentState = context.get(ISchedulingState)
					val currentContext = mapping.get(currentState)
					currentContext.get(IMaiaContextAction.KEY_RESULT)
				} else {
					null
				}
			val nextState = scheme.getNextState(currentResult)
			val nextContext = stateMapping.get(nextState)
			return getNextAction(nextContext)
		}
	}
	
	override add(IMaiaContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override block(IMaiaContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override blockAll() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override restart(IMaiaContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override restartAll() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override remove(IMaiaContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override removeAll() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}