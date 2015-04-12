package ru.agentlab.maia.lifecycle

interface ILifecycleTransition {

	def String getName()

	def ILifecycleState getFromState()

	def ILifecycleState getToState()
}