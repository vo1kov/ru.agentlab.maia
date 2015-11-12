package ru.agentlab.maia.behaviour.pattern

import java.util.HashMap
import javax.inject.Inject
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourUnordered

class PatternBehaviour extends BehaviourUnordered implements IPatternBehaviour {

	val stateMapping = new HashMap<PatternState, IBehaviour>

	PatternScheme scheme

	@Inject
	new(PatternScheme scheme) {
		this.scheme = scheme
	}

	def IBehaviour getCurrentNode() {
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

	def link(IBehaviour context, String stateName) {
		val state = scheme.allStates.findFirst [
			name == stateName
		]
		if (state == null) {
			throw new IllegalArgumentException("Scheme have no state " + stateName)
		}
//		stateMapping.put(stateName, context)
	}

	def remove(IBehaviour context) {
		stateMapping.remove(context)
	}

	override clear() {
		stateMapping.clear
	}

	override protected internalSchedule() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override notifyChildReady(IBehaviour task) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override notifyChildBlocked() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override notifyChildSuccess() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override notifyChildFailed() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override notifyChildWorking() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override isFirst(IBehaviour subtask) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override isReady() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}