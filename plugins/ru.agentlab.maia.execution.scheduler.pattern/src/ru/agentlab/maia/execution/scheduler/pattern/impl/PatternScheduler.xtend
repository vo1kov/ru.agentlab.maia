package ru.agentlab.maia.execution.scheduler.pattern.impl

import java.util.concurrent.ConcurrentHashMap
import javax.inject.Inject
import ru.agentlab.maia.execution.scheduler.AbstractScheduler
import ru.agentlab.maia.execution.scheduler.pattern.IPatternScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.memory.IMaiaContext

class PatternScheduler extends AbstractScheduler implements IPatternScheduler {

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
	
	override handleChildUnknown(IExecutionNode child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override handleChildReady(IExecutionNode child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override handleChildInWork(IExecutionNode child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override handleChildWait(IExecutionNode child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override handleChildFinish(IExecutionNode child) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}