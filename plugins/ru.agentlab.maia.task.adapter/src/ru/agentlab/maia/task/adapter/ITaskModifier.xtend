package ru.agentlab.maia.task.adapter

import ru.agentlab.maia.task.ITask

interface ITaskModifier<T> {
	
	val static final String KEY_TYPE = "type"
	
	def void modify(ITask task, T input)
	
}