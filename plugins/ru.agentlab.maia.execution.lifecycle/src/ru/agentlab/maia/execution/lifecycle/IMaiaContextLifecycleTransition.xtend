package ru.agentlab.maia.execution.lifecycle

interface IMaiaContextLifecycleTransition {

	def String getName()

	def IMaiaContextLifecycleState getFromState()

	def IMaiaContextLifecycleState getToState()
}