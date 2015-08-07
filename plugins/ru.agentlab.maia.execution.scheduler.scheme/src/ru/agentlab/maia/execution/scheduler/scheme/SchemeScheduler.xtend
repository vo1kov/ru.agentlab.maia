package ru.agentlab.maia.execution.scheduler.scheme

import java.util.concurrent.ConcurrentHashMap
import javax.inject.Inject
import ru.agentlab.maia.execution.AbstractScheduler
import ru.agentlab.maia.execution.IMaiaExecutorNode

class SchemeScheduler extends AbstractScheduler {

	val stateMapping = new ConcurrentHashMap<String, IMaiaExecutorNode>

	@Inject
	IMaiaExecutorSchedulerScheme scheme

	override IMaiaExecutorNode getCurrentNode() {
		return context.get(KEY_CURRENT_CONTEXT) as IMaiaExecutorNode
	}

	override getNextNode() {
		val currentResult = if (currentNode != null) {
//				currentContext.get(IMaiaContextAction.KEY_RESULT)
			} else {
				null
			}
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	def synchronized link(IMaiaExecutorNode context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
		stateMapping.put(stateName, context)
	}

	override synchronized remove(IMaiaExecutorNode context) {
		stateMapping.remove(context)
	}

	override synchronized removeAll() {
		stateMapping.clear
	}

	override synchronized isEmpty() {
		return stateMapping.empty
	}

	override add(IMaiaExecutorNode context) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}