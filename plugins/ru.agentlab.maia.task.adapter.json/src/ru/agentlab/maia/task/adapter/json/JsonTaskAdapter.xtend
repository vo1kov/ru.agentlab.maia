package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.HashMap
import java.util.List
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskAdapter
import ru.agentlab.maia.task.ITaskException
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter

class JsonTaskAdapter implements ITaskAdapter<String> {

	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	val protected parametersCache = new HashMap<String, ITaskParameter<?>>

	val protected exceptionsCache = new HashMap<String, ITaskException>

	val protected subtasksCache = new HashMap<String, ITask>

	var protected Map<?, ?> parsed

	var IInjector injector

	@Inject
	new(IInjector injector) {
		this.injector = injector
	}

	override ITask adapt(String json) {
		parsed = JsonPath.using(conf).parse(json).read("$") as Map<?, ?>
		return parsed.adapt
	}

	def ITask adapt(Map<?, ?> parsed) {
		return createTask(parsed) => [
			extractLabel(parsed)
			extractExceptions(parsed)
			extractInputs(parsed)
			extractOutputs(parsed)
		]
	}

	def protected ITask createTask(Map<?, ?> parsed) {
		val typeString = parsed.get("type") as String
		val uuid = parsed.get("uuid") as String
		val type = Class.forName(typeString) as Class<? extends ITask>
		return injector.deploy(type, uuid)
	}

	def protected void extractLabel(ITask task, Map<?, ?> parsed) {
		val label = parsed.get("label") as String
		task.label = label
	}

	def protected void extractExceptions(ITask task, Map<?, ?> parsed) {
		val exceptions = parsed.get("exceptions") as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val exception = new TaskException(label)
			task.addException(exception)
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void extractInputs(ITask task, Map<?, ?> parsed) {
		val inputs = parsed.get("inputs") as List<Map<String, String>>
		inputs?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val type = get("type")
			val javaType = Class.forName(type)
			val input = new TaskParameter(label, javaType)
			task.addInput(input)
			parametersCache.put(uuid, input)
		]
	}

	def protected void extractOutputs(ITask task, Map<?, ?> parsed) {
		val outputs = parsed.get("outputs") as List<Map<String, String>>
		outputs?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val type = get("type")
			val javaType = Class.forName(type)
			val output = new TaskParameter(label, javaType)
			task.addOutput(output)
			parametersCache.put(uuid, output)
		]
	}

}