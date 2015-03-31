package ru.agentlab.maia.behaviour

interface IBehaviourTransition {

	def String getName()

	def IBehaviourState getFromState()

	def IBehaviourState getToState()

}