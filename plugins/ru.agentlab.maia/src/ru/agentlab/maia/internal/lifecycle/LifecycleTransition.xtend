package ru.agentlab.maia.internal.lifecycle

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.lifecycle.ILifecycleState
import ru.agentlab.maia.lifecycle.ILifecycleTransition

@Accessors
class LifecycleTransition implements ILifecycleTransition {

	var String name

	var ILifecycleState fromState

	var ILifecycleState toState

	new(String name, ILifecycleState fromState, ILifecycleState toState) {
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