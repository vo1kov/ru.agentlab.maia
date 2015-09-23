package ru.agentlab.maia.execution.scheduler.fsm.impl

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.scheduler.AbstractExecutionScheduler
import ru.agentlab.maia.execution.scheduler.fsm.IFsmScheduler

class FsmScheduler extends AbstractExecutionScheduler implements IFsmScheduler {

	val List<DefaultFsmTransition> defaultTransitions = new ArrayList

	val List<ExceptionFsmTransition> exceptionTransitions = new ArrayList

	val List<EventFsmTransition> eventTransitions = new ArrayList

	override schedule() {
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
		return null
	}

	def DefaultFsmTransition getDefaultTransition(IExecutionNode from) {
		return defaultTransitions.findFirst[it.from == from]
	}

	def ExceptionFsmTransition getExceptionTransition(IExecutionNode from) {
		return exceptionTransitions.findFirst[it.from == from]
	}

	def EventFsmTransition getEventTransition(IExecutionNode from) {
		return eventTransitions.findFirst[it.from == from]
	}

	override addDefaultTransition(IExecutionNode from, IExecutionNode to) {
		val existing = defaultTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new DefaultFsmTransition(from, to)
			defaultTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addExceptionTransition(IExecutionNode from, IExecutionNode to, Class<? extends RuntimeException> exc) {
		val existing = exceptionTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new ExceptionFsmTransition(from, to, exc)
			exceptionTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override addEventTransition(IExecutionNode from, IExecutionNode to, String topic) {
		val existing = eventTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new EventFsmTransition(from, to, topic)
			eventTransitions += transition
			return transition
		} else {
			return null
		}
	}
	
	override onChildUnknown(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override onChildReady(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override onChildInWork(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override onChildWaiting(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override onChildFinished(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override onChildException(IExecutionNode node) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	

}