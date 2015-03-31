package ru.agentlab.maia.behaviour.sheme

interface IBehaviourTransition {

	def String getName()

	def IBehaviourState getFromState()

	def IBehaviourState getToState()

}