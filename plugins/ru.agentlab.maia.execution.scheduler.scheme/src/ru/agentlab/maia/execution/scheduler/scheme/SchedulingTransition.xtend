package ru.agentlab.maia.execution.scheduler.scheme

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class SchedulingTransition implements IMaiaContextSchedulerTransition {

	var String name

	var IMaiaContextSchedulerState fromState

	var IMaiaContextSchedulerState toState

	new(String name, IMaiaContextSchedulerState fromState, IMaiaContextSchedulerState toState) {
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