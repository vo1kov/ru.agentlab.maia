package ru.agentlab.maia.execution.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingTransition
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

@Accessors
abstract class SchedulingTransition implements ISchedulingTransition {

	var String name

	var ISchedulingState fromState

	var ISchedulingState toState

	new(String name, ISchedulingState fromState, ISchedulingState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

	override equals(Object obj) {
		if (obj instanceof SchedulingTransition) {
			return obj.fromState == fromState && obj.toState == toState
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		'''(«fromState» -> «toState»)'''
	}

}