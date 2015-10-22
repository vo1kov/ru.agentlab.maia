package ru.agentlab.maia.task

interface ITaskAdapter<T> {

	val static final String KEY_LANGUAGE = "language"

	val static final String KEY_TYPE = "type"

	def ITask adapt(T object)

}