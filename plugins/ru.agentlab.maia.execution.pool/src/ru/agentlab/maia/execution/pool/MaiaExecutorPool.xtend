package ru.agentlab.maia.execution.pool

import java.util.concurrent.ExecutorService
import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingScheme
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingStateMapping

class MaiaExecutorPool {

	@Inject
	IMaiaContext context

	@Inject
	ExecutorService executor

	def void init() {

		executor.submit [
			var rootContext = context
			var IMaiaContextAction action = null
			while (rootContext != null && action == null) {
				// test current context have action
				action = rootContext.get(IMaiaContextAction)
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
			return action
		]
	}

}