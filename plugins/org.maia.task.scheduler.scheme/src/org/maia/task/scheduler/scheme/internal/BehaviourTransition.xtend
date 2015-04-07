package org.maia.task.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.task.scheduler.scheme.IBehaviourState
import org.maia.task.scheduler.scheme.IBehaviourTransition

@Accessors
abstract class BehaviourTransition implements IBehaviourTransition {

	var String name

	var IBehaviourState fromState

	var IBehaviourState toState

	new(String name, IBehaviourState fromState, IBehaviourState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

	override equals(Object obj) {
		if (obj instanceof BehaviourTransition) {
			return obj.fromState == fromState && obj.toState == toState
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		'''(«fromState» -> «toState»)'''
	}

}