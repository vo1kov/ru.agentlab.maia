package ru.agentlab.maia.task.adapter

import ru.agentlab.maia.task.ITask

interface ITaskAdapter<T> {

	val static final String KEY_LANGUAGE = "language"

	val static final String KEY_TYPE = "type"

	def ITask adapt(T object)

}