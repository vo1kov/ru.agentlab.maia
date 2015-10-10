package ru.agentlab.maia.task

interface ITaskAdapter<T> {

	def ITask adapt(T object)

}