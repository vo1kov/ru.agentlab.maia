package ru.agentlab.maia.lifecycle

interface ILifecycleService {

	def ILifecycleState getState()

	def void setState(ILifecycleState state) throws IllegalStateException

	def Iterable<ILifecycleState> getPossibleStates()

	def Iterable<ILifecycleTransition> getStatesTransitions()

}

interface ILifecycleState {

	def String getName()

}

interface ILifecycleTransition {

	def String getName()

	def ILifecycleState getFromState()

	def ILifecycleState getToState()
}