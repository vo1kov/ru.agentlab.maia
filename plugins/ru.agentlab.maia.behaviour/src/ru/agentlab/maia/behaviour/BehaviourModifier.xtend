package ru.agentlab.maia.behaviour

import java.util.HashMap
import java.util.List
import java.util.Map

abstract class BehaviourModifier implements IBehaviourModifier {

	val public static String TASK_UUID = "uuid"

	val public static String TASK_TYPE = "type"

	val public static String TASK_LABEL = "label"

	val public static String TASK_EXCEPTIONS = "exceptions"

	val public static String TASK_INPUTS = "inputs"

	val public static String TASK_OUTPUTS = "outputs"

	val public static String EXCEPTION_UUID = "uuid"

	val public static String EXCEPTION_TYPE = "type"

	val public static String EXCEPTION_LABEL = "label"

	val public static String INPUT_UUID = "uuid"

	val public static String INPUT_TYPE = "type"

	val public static String INPUT_LABEL = "label"

	val public static String OUTPUT_UUID = "uuid"

	val public static String OUTPUT_TYPE = "type"

	val public static String OUTPUT_LABEL = "label"
	
	val protected parametersCache = new HashMap<String, IBehaviourParameter<?>>

	val protected exceptionsCache = new HashMap<String, IBehaviourException>

	val protected subtasksCache = new HashMap<String, IBehaviour>

	override modify(IBehaviour task, Map<String, ?> parsed) {
		task.modifyLabel(parsed)
		task.modifyExceptions(parsed)
		task.modifyInputs(parsed)
		task.modifyOutputs(parsed)
	}

	def protected void modifyLabel(IBehaviour task, Map<String, ?> parsed) {
		val label = parsed.get(TASK_LABEL) as String
		if (task.label != label) {
			task.label = label
		}
	}

	def protected void modifyExceptions(IBehaviour task, Map<String, ?> parsed) {
		val exceptions = parsed.get(TASK_EXCEPTIONS) as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get(EXCEPTION_UUID)
			val label = get(EXCEPTION_LABEL)
			var exception = task.exceptions?.findFirst[it.name == label]
			if (exception == null) {
				exception = new BehaviourException(label)
				task.addException(exception)
			}
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void modifyInputs(IBehaviour task, Map<String, ?> parsed) {
		val inputs = parsed.get(TASK_INPUTS) as List<Map<String, String>>
		inputs?.forEach [
			val uuid = get(INPUT_UUID)
			val label = get(INPUT_LABEL)
			val type = get(INPUT_TYPE)
			val javaType = Class.forName(type)
			var input = task.inputs?.findFirst[it.name == label && it.type == javaType]
			if (input == null) {
				input = new BehaviourParameter(label, javaType)
				task.addInput(input)
			}
			parametersCache.put(uuid, input)
		]
	}

	def protected void modifyOutputs(IBehaviour task, Map<String, ?> parsed) {
		val outputs = parsed.get(TASK_OUTPUTS) as List<Map<String, String>>
		outputs?.forEach [
			val uuid = get(OUTPUT_UUID)
			val label = get(OUTPUT_LABEL)
			val type = get(OUTPUT_TYPE)
			val javaType = Class.forName(type)
			var output = task.outputs?.findFirst[it.name == label && it.type == javaType]
			if (output == null) {
				output = new BehaviourParameter(label, javaType)
				task.addOutput(output)
			}
			parametersCache.put(uuid, output)
		]
	}
}