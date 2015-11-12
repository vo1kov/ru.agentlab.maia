package ru.agentlab.maia.behaviour.fsm

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourUnordered

class FsmBehaviour extends BehaviourUnordered implements IFsmBehaviour {

	val List<DefaultFsmTransition> defaultTransitions = new ArrayList

	val List<ExceptionFsmTransition> exceptionTransitions = new ArrayList

	val List<EventFsmTransition> eventTransitions = new ArrayList

//	override schedule() {
//		val excTransition = current.exceptionTransition
//		if (excTransition != null) {
//			return excTransition.to
//		}
//		val defTransition = current.defaultTransition
//		if (defTransition != null) {
//			return defTransition.to
//		}
//		val eventTransition = current.eventTransition
//		if (eventTransition != null) {
//			return eventTransition.to
//		}
//		return null
//	}
	def DefaultFsmTransition getDefaultTransition(IBehaviour from) {
		return defaultTransitions.findFirst[it.from == from]
	}

	def ExceptionFsmTransition getExceptionTransition(IBehaviour from) {
		return exceptionTransitions.findFirst[it.from == from]
	}

	def EventFsmTransition getEventTransition(IBehaviour from) {
		return eventTransitions.findFirst[it.from == from]
	}

	override addDefaultTransition(IBehaviour from, IBehaviour to) {
		val existing = defaultTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new DefaultFsmTransition(from, to)
			defaultTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addExceptionTransition(IBehaviour from, IBehaviour to, Class<? extends RuntimeException> exc) {
		val existing = exceptionTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new ExceptionFsmTransition(from, to, exc)
			exceptionTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addEventTransition(IBehaviour from, IBehaviour to, String topic) {
		val existing = eventTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new EventFsmTransition(from, to, topic)
			eventTransitions += transition
			return transition
		} else {
			return null
		}
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