package ru.agentlab.maia.task.adapter.json

import java.util.HashMap
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskException
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.adapter.ITaskModifier

abstract class JsonTaskModifier implements ITaskModifier<Map<String, ?>> {
	
	val protected parametersCache = new HashMap<String, ITaskParameter<?>>

	val protected exceptionsCache = new HashMap<String, ITaskException>

	val protected subtasksCache = new HashMap<String, ITask>

	override modify(ITask task, Map<String, ?> parsed) {
		task.modifyLabel(parsed)
		task.modifyExceptions(parsed)
		task.modifyInputs(parsed)
		task.modifyOutputs(parsed)
	}

	def protected void modifyLabel(ITask task, Map<String, ?> parsed) {
		val label = parsed.get(JsonConstants.TASK_LABEL) as String
		if (task.label != label) {
			task.label = label
		}
	}

	def protected void modifyExceptions(ITask task, Map<String, ?> parsed) {
		val exceptions = parsed.get(JsonConstants.EXCEPTIONS) as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get(JsonConstants.EXCEPTION_UUID)
			val label = get(JsonConstants.EXCEPTION_LABEL)
			var exception = task.exceptions?.findFirst[it.name == label]
			if (exception == null) {
				exception = new TaskException(label)
				task.addException(exception)
			}
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void modifyInputs(ITask task, Map<String, ?> parsed) {
		val inputs = parsed.get(JsonConstants.INPUTS) as List<Map<String, String>>
		inputs?.forEach [
			val uuid = get(JsonConstants.INPUT_UUID)
			val label = get(JsonConstants.INPUT_LABEL)
			val type = get(JsonConstants.INPUT_TYPE)
			val javaType = Class.forName(type)
			var input = task.inputs?.findFirst[it.name == label && it.type == javaType]
			if (input == null) {
				input = new TaskParameter(label, javaType)
				task.addInput(input)
			}
			parametersCache.put(uuid, input)
		]
	}

	def protected void modifyOutputs(ITask task, Map<String, ?> parsed) {
		val outputs = parsed.get(JsonConstants.OUTPUTS) as List<Map<String, String>>
		outputs?.forEach [
			val uuid = get(JsonConstants.OUTPUT_UUID)
			val label = get(JsonConstants.OUTPUT_LABEL)
			val type = get(JsonConstants.OUTPUT_TYPE)
			val javaType = Class.forName(type)
			var output = task.outputs?.findFirst[it.name == label && it.type == javaType]
			if (output == null) {
				output = new TaskParameter(label, javaType)
				task.addOutput(output)
			}
			parametersCache.put(uuid, output)
		]
	}
}