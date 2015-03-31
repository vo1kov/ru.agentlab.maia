package ru.agentlab.maia.behaviour

interface IActionTransition {

	def String getName()

	def IActionState getFromState()

	def IActionState getToState()

}