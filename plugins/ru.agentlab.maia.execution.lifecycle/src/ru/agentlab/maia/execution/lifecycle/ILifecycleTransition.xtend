package ru.agentlab.maia.execution.lifecycle

interface ILifecycleTransition {

	def String getName()

	def ILifecycleState getFromState()

	def ILifecycleState getToState()
}