package ru.agentlab.maia.execution

interface IStateFull<T> {

	def String getState()

	def String setState(String newState)

	def void addStateListener(IStateChangedListener<T> listener)

	def void removeStateListener(IStateChangedListener<T> listener)

}