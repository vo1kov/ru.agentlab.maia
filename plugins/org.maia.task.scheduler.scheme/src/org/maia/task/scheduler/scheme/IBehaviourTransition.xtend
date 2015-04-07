package org.maia.task.scheduler.scheme

interface IBehaviourTransition {

	def String getName()

	def IBehaviourState getFromState()

	def IBehaviourState getToState()

}