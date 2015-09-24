package ru.agentlab.maia.execution.scheduler.pattern.impl

import java.util.concurrent.ConcurrentHashMap
import javax.inject.Inject
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.scheduler.AbstractExecutionScheduler
import ru.agentlab.maia.execution.scheduler.pattern.IPatternScheduler
import ru.agentlab.maia.memory.IMaiaContext

class PatternScheduler extends AbstractExecutionScheduler implements IPatternScheduler {

	val stateMapping = new ConcurrentHashMap<String, IExecutionNode>

	IMaiaContext context

	PatternScheme scheme

	@Inject
	new(IMaiaContext context, PatternScheme scheme) {
		this.context = context
		this.scheme = scheme
	}

	def IExecutionNode getCurrentNode() {
//		return context.get(KEY_CURRENT_CONTEXT) as IExecutionNode
	}

	def getNextNode() {
		val currentResult = if (currentNode != null) {
//				currentContext.get(IMaiaContextAction.KEY_RESULT)
			} else {
				null
			}
		val nextState = scheme.getNextState(currentResult)
		val nextContext = stateMapping.get(nextState)
		return nextContext
	}

	def synchronized link(IExecutionNode context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
		stateMapping.put(stateName, context)
	}

	def synchronized remove(IExecutionNode context) {
		stateMapping.remove(context)
	}

	override synchronized removeAll() {
		stateMapping.clear
	}

	override synchronized isEmpty() {
		return stateMapping.empty
	}

	def add(IExecutionNode context) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override schedule() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected onChildChangedState(IExecutionNode node, String oldState, String newState) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}