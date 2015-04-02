package ru.agentlab.maia.lifecycle.scheme

import ru.agentlab.maia.lifecycle.scheme.ILifecycleState

interface ILifecycleTransition {

	def String getName()

	def ILifecycleState getFromState()

	def ILifecycleState getToState()
}