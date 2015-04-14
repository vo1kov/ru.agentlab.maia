package ru.agentlab.maia.execution.scheduler.scheme

import java.util.concurrent.ConcurrentHashMap
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.bounded.IMaiaBoundedContextScheduler

class SchemeScheduler implements IMaiaBoundedContextScheduler {

	@Inject
	IMaiaContextSchedulerScheme scheme

	val stateMapping = new ConcurrentHashMap<String, IMaiaContext>

	override getNextContext() {
		val currentState = scheme.currentState
		val currentResult = if (currentState != null) {
				val currentContext = stateMapping.get(currentState)
				currentContext?.get(IMaiaContextAction.KEY_RESULT)
			} else {
				null
			}
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	override synchronized add(IMaiaContext context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
		stateMapping.put(stateName, context)
	}

	override synchronized remove(IMaiaContext context) {
		stateMapping.remove(context)
	}

	override synchronized removeAll() {
		stateMapping.clear
	}

}