package ru.agentlab.maia.execution.scheduler.scheme

import java.util.concurrent.ConcurrentHashMap
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.bounded.IMaiaBoundedContextScheduler

class SchemeScheduler implements IMaiaBoundedContextScheduler {

	val static LOGGER = LoggerFactory.getLogger(SchemeScheduler)

	val stateMapping = new ConcurrentHashMap<String, IMaiaExecutorNode>

	@Inject
	IMaiaExecutorSchedulerScheme scheme

	@Inject
	IMaiaContext context

	@PostConstruct
	def void init() {
		context.set(KEY_CURRENT_CONTEXT, null)
		val parentScheduler = context.parent.get(IMaiaExecutorScheduler)
		if (parentScheduler != null) {
			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentScheduler)
			parentScheduler?.add(this)
		}
	}

	override IMaiaExecutorNode getCurrentContext() {
		return context.get(KEY_CURRENT_CONTEXT) as IMaiaExecutorNode
	}

	override getNextContext() {
		val currentResult = if (currentContext != null) {
//				currentContext.get(IMaiaContextAction.KEY_RESULT)
			} else {
				null
			}
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	override synchronized link(IMaiaExecutorNode context, String stateName) {
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