package ru.agentlab.maia.execution.scheduler.pattern.impl

import java.util.HashMap
import javax.inject.Inject
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.scheduler.TaskSchedulerUnordered
import ru.agentlab.maia.execution.scheduler.pattern.IPatternScheduler
import ru.agentlab.maia.memory.IMaiaContext

class PatternScheduler extends TaskSchedulerUnordered implements IPatternScheduler {

	val stateMapping = new HashMap<PatternState, ITask>

	IMaiaContext context

	PatternScheme scheme

	@Inject
	new(IMaiaContext context, PatternScheme scheme) {
		this.context = context
		this.scheme = scheme
	}

	def ITask getCurrentNode() {
//		return context.get(KEY_CURRENT_CONTEXT) as ITask
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

	def link(ITask context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
		stateMapping.put(stateName, context)
	}

	def remove(ITask context) {
		stateMapping.remove(context)
	}

	override clear() {
		stateMapping.clear
	}

	override protected internalSchedule() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override notifySubtaskReady(ITask task) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override notifySubtaskBlocked() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override notifySubtaskSuccess() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override notifySubtaskFailed() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override notifySubtaskWorking() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}