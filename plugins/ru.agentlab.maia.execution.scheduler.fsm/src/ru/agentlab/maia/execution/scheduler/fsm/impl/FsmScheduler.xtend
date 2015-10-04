package ru.agentlab.maia.execution.scheduler.fsm.impl

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.scheduler.fsm.IFsmScheduler
import ru.agentlab.maia.execution.scheduler.TaskSchedulerUnordered

class FsmScheduler extends TaskSchedulerUnordered implements IFsmScheduler {

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
	def DefaultFsmTransition getDefaultTransition(ITask from) {
		return defaultTransitions.findFirst[it.from == from]
	}

	def ExceptionFsmTransition getExceptionTransition(ITask from) {
		return exceptionTransitions.findFirst[it.from == from]
	}

	def EventFsmTransition getEventTransition(ITask from) {
		return eventTransitions.findFirst[it.from == from]
	}

	override addDefaultTransition(ITask from, ITask to) {
		val existing = defaultTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new DefaultFsmTransition(from, to)
			defaultTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addExceptionTransition(ITask from, ITask to, Class<? extends RuntimeException> exc) {
		val existing = exceptionTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new ExceptionFsmTransition(from, to, exc)
			exceptionTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addEventTransition(ITask from, ITask to, String topic) {
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