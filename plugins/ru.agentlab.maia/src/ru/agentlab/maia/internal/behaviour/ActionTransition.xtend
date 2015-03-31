package ru.agentlab.maia.internal.behaviour

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionState
import ru.agentlab.maia.behaviour.IActionTransition

@Accessors
abstract class ActionTransition implements IActionTransition {

	var String name

	var IActionState fromState

	var IActionState toState

	new(String name, IActionState fromState, IActionState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

	override equals(Object obj) {
		if (obj instanceof ActionTransition) {
			return obj.fromState == fromState && obj.toState == toState
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		'''[«fromState»] -> [«toState»]'''
	}

}