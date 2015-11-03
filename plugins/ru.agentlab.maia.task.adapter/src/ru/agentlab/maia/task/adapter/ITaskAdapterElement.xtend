package ru.agentlab.maia.task.adapter

import ru.agentlab.maia.task.ITask

interface ITaskAdapterElement<T> {

	val static final String KEY_LANGUAGE = "language"

	val static final String KEY_TYPE = "type"
	
	def void adapt(ITask task, T object)
	
}