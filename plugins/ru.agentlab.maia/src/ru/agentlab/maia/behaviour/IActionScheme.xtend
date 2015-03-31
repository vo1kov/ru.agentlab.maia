package ru.agentlab.maia.behaviour

import java.util.List

interface IActionScheme extends IActionState {

	def IActionState getInitialState()

	def IActionState getFinalState()

	def List<IActionState> getStates()

	def List<IActionTransition> getTransitions()

}