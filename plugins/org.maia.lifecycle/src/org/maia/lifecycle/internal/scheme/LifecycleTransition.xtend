package org.maia.lifecycle.internal.scheme

import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.lifecycle.scheme.ILifecycleState
import org.maia.lifecycle.scheme.ILifecycleTransition

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