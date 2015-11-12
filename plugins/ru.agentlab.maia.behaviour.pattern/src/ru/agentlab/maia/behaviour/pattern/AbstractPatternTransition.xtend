package ru.agentlab.maia.behaviour.pattern

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class AbstractPatternTransition implements IPatternTransition {

	var String name

	var PatternState fromState

	var PatternState toState

	new(String name, PatternState fromState, PatternState toState) {
		this.name = name
		this.fromState = fromState
		this.toState = toState
	}

	override equals(Object obj) {
		if (obj instanceof AbstractPatternTransition) {
			return obj.fromState == fromState && obj.toState == toState
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		'''(�fromState� -> �toState�)'''
	}

}