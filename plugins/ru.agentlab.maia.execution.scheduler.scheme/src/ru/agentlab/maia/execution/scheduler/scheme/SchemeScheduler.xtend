package ru.agentlab.maia.execution.scheduler.scheme

import java.util.concurrent.ConcurrentHashMap
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.bounded.IMaiaBoundedContextScheduler

class SchemeScheduler implements IMaiaBoundedContextScheduler {

	val stateMapping = new ConcurrentHashMap<String, IMaiaContext>

	@Inject
	IMaiaExecutorSchedulerScheme scheme

	@Inject
	IMaiaContext conext

	@PostConstruct
	def void init() {
		conext.set(KEY_CURRENT_CONTEXT, null)
	}

	override IMaiaContext getCurrentContext() {
		return conext.get(KEY_CURRENT_CONTEXT) as IMaiaContext
	}

	override getNextContext() {
		val currentResult = if (currentContext != null) {
				currentContext.get(IMaiaContextAction.KEY_RESULT)
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