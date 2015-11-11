package ru.agentlab.maia.task.adapter

import java.util.Map
import ru.agentlab.maia.task.ITask

interface ITaskAdapter<T> {

	val static final String KEY_LANGUAGE = "language"

	def ITask adapt(T object)

	def ITask adapt(Map<String, ?> object)

}