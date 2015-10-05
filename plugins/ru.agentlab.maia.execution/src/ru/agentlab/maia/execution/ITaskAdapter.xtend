package ru.agentlab.maia.execution

interface ITaskAdapter<T> {

	def ITask adapt(T object)

}