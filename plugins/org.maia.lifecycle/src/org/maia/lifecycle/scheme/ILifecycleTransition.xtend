package org.maia.lifecycle.scheme

interface ILifecycleTransition {

	def String getName()

	def ILifecycleState getFromState()

	def ILifecycleState getToState()
}