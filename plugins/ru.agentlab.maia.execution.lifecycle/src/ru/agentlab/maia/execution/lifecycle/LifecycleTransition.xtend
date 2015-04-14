package ru.agentlab.maia.execution.lifecycle

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class LifecycleTransition implements IMaiaContextLifecycleTransition {

	var String name

	var IMaiaContextLifecycleState fromState

	var IMaiaContextLifecycleState toState

	new(String name, IMaiaContextLifecycleState fromState, IMaiaContextLifecycleState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

	override equals(Object obj) {
		if (obj instanceof LifecycleTransition) {
			return obj.fromState == fromState && obj.toState == toState
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		'''[«fromState»] -> [«toState»]'''
	}

}