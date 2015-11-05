package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.HashMap
import java.util.List
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskException
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.adapter.ITaskAdapter

abstract class JsonTaskAdapter implements ITaskAdapter<String> {

	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	val protected parametersCache = new HashMap<String, ITaskParameter<?>>

	val protected exceptionsCache = new HashMap<String, ITaskException>

	val protected subtasksCache = new HashMap<String, ITask>

	val ITaskRegistry registry

	@Inject
	new(ITaskRegistry registry) {
		this.registry = registry
	}

	override ITask adapt(String json) {
		val parsed = JsonPath.using(conf).parse(json).read("$") as Map<?, ?>
		return adapt(parsed)
	}

	def ITask adapt(Map<?, ?> parsed) {
		val uuid = parsed.get("uuid") as String
		val typeString = parsed.get("type") as String
		var type = Class.forName(typeString) as Class<? extends ITask>
		var task = internalFindTask(uuid, type)
		if (task == null) {
			task = internalCreateTask(uuid, type)
		}
		task.internalAdaptLabel(parsed)
		val external = parsed.get("external") as Map<?, ?>
		task.internalAdaptExceptions(external)
		task.internalAdaptInputs(external)
		task.internalAdaptOutputs(external)
//		val refs = Activator.context.getServiceReferences(
//			ITaskAdapterElement,
//			'''
//				(&
//					(«ITaskAdapterElement.KEY_LANGUAGE»=json)
//					(«ITaskAdapterElement.KEY_TYPE»=«task.class.name»)
//				)
//			'''
//		)
//		if (!refs.empty) {
//			val ref = refs.get(0)
//			val service = Activator.context.getService(ref)
//			if (service != null) {
//				service.adapt(task, parsed)
//			}
//		}
		return task
	}

	def protected ITask internalFindTask(String uuid, Class<? extends ITask> type) {
		val task = registry.get(uuid)
		if (task != null && type.isAssignableFrom(task.class)) {
			return type.cast(task)
		} else {
			return null
		}
	}

	def protected ITask internalCreateTask(String uuid, Class<? extends ITask> type) {
		val task = type.newInstance
		registry.put(uuid, task)
		return task
	}

	def protected void internalAdaptLabel(ITask task, Map<?, ?> parsed) {
		val label = parsed.get("label") as String
		if (task.label != label) {
			task.label = label
		}
	}

	def protected void internalAdaptExceptions(ITask task, Map<?, ?> parsed) {
		val exceptions = parsed.get("exceptions") as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			var exception = task.exceptions.findFirst[it.name == label]
			if (exception == null) {
				exception = new TaskException(label)
				task.addException(exception)
			}
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void internalAdaptInputs(ITask task, Map<?, ?> parsed) {
		val inputs = parsed.get("inputs") as List<Map<String, String>>
		inputs?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val type = get("type")
			val javaType = Class.forName(type)
			var input = task.inputs.findFirst[it.name == label && it.type == javaType]
			if (input == null) {
				input = new TaskParameter(label, javaType)
				task.addInput(input)
			}
			parametersCache.put(uuid, input)
		]
	}

	def protected void internalAdaptOutputs(ITask task, Map<?, ?> parsed) {
		val outputs = parsed.get("outputs") as List<Map<String, String>>
		outputs?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val type = get("type")
			val javaType = Class.forName(type)
			var output = task.outputs.findFirst[it.name == label && it.type == javaType]
			if (output == null) {
				output = new TaskParameter(label, javaType)
				task.addOutput(output)
			}
			parametersCache.put(uuid, output)
		]
	}

}