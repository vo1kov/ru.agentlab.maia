package ru.agentlab.maia.task

import java.util.Map

interface ITaskModifier {

	val static final String KEY_TYPE = "type"

	def void modify(ITask task, Map<String, ?> input)

}