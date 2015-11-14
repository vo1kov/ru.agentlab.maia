package ru.agentlab.maia.adapter.behaviour.json

import java.util.HashMap
import java.util.List
import java.util.Map
import ru.agentlab.maia.adapter.IModifier
import ru.agentlab.maia.behaviour.BehaviourException
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourException
import ru.agentlab.maia.behaviour.IBehaviourParameter

class BehaviourJsonModifier implements IModifier<IBehaviour> {

	val public static String KEY_LABEL = "label"

	val public static String KEY_EXCEPTIONS = "exceptions"

	val public static String KEY_INPUTS = "inputs"

	val public static String KEY_OUTPUTS = "outputs"

	val protected parametersCache = new HashMap<String, IBehaviourParameter<?>>

	val protected exceptionsCache = new HashMap<String, IBehaviourException>

	val protected subtasksCache = new HashMap<String, IBehaviour>

	override modify(IBehaviour task, Object... objects) {
		val parsed = objects.get(0) as Map<String, ?>
		task.modifyLabel(parsed)
		task.modifyExceptions(parsed)
		task.modifyInputs(parsed)
		task.modifyOutputs(parsed)
	}

	def protected void modifyLabel(IBehaviour task, Map<String, ?> parsed) {
		val label = parsed.get(KEY_LABEL) as String
		if (task.label != label) {
			task.label = label
		}
	}

	def protected void modifyExceptions(IBehaviour task, Map<String, ?> parsed) {
		val exceptions = parsed.get(KEY_EXCEPTIONS) as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get(BehaviourJsonAdapter.KEY_UUID)
			val label = get(KEY_LABEL)
			var exception = task.exceptions?.findFirst[it.name == label]
			if (exception == null) {
				exception = new BehaviourException(label)
				task.addException(exception)
			}
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void modifyInputs(IBehaviour task, Map<String, ?> parsed) {
		val inputs = parsed.get(KEY_INPUTS) as List<Map<String, String>>
		inputs?.forEach [
			val uuid = get(BehaviourJsonAdapter.KEY_UUID)
			val type = get(BehaviourJsonAdapter.KEY_TYPE)
			val label = get(KEY_LABEL)
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
		val outputs = parsed.get(KEY_OUTPUTS) as List<Map<String, String>>
		outputs?.forEach [
			val uuid = get(BehaviourJsonAdapter.KEY_UUID)
			val type = get(BehaviourJsonAdapter.KEY_TYPE)
			val label = get(KEY_LABEL)
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