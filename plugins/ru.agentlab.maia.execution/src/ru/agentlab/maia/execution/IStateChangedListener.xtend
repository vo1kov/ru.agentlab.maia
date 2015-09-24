package ru.agentlab.maia.execution

interface IStateChangedListener<T> {
	
	def void onStateChanged(T object, String oldState, String newState)
}