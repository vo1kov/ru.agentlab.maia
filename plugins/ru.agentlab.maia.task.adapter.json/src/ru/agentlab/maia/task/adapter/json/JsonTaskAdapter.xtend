package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.HashMap
import java.util.List
import java.util.Map
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskException
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.adapter.ITaskAdapter
import ru.agentlab.maia.task.adapter.ITaskAdapterElement
import ru.agentlab.maia.task.adapter.json.internal.Activator

class JsonTaskAdapter implements ITaskAdapter<String> {

	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	val protected parametersCache = new HashMap<String, ITaskParameter<?>>

	val protected exceptionsCache = new HashMap<String, ITaskException>

	val protected subtasksCache = new HashMap<String, ITask>

	val ITaskRegistry registry

	new(ITaskRegistry registry) {
		this.registry = registry
	}

	override ITask adapt(IContext context, String json) {
		val parsed = JsonPath.using(conf).parse(json).read("$") as Map<?, ?>
		return context.adapt(parsed)
	}

	def ITask adapt(IContext context, Map<?, ?> parsed) {
		val uuid = parsed.get("uuid") as String
		val typeString = parsed.get("type") as String
		var type = Class.forName(typeString) as Class<? extends ITask>
		var task = context.findTask(uuid, type)
		if (task == null) {
			task = context.createTask(uuid, type)
		}
		task.adaptLabel(parsed)
		task.adaptExternal(parsed)
		val refs = Activator.context.getServiceReferences(
			ITaskAdapterElement,
			'''
				(&
					(«ITaskAdapterElement.KEY_LANGUAGE»=json)
					(«ITaskAdapterElement.KEY_TYPE»=«task.class.name»)
				)
			'''
		)
		if (!refs.empty) {
			val ref = refs.get(0)
			val service = Activator.context.getService(ref)
			if (service != null) {
				service.adapt(task, parsed)
			}
		}
		return task
	}

	def protected ITask findOrCreateTask(IContext context, String uuid, Class<? extends ITask> type) {
		var task = context.findTask(uuid, type)
		if (task == null) {
			task = context.createTask(uuid, type)
		}
		return task
	}

	def protected ITask findTask(IContext context, String uuid, Class<? extends ITask> type) {
		val task = context.getService(uuid)
		if (type.isAssignableFrom(task.class)) {
			return type.cast(task)
		} else {
			return null
		}
	}

	def protected ITask createTask(IContext context, String uuid, Class<? extends ITask> type) {
		return context.getService(IInjector).deploy(type, uuid)
	}

	def protected void adaptExternal(ITask task, Map<?, ?> parsed) {
		val external = parsed.get("external") as Map<?, ?>
		task.adaptExternalExceptions(external)
		task.adaptExternalInputs(external)
		task.adaptExternalOutputs(external)
	}

//	def protected ITask createTask(Map<?, ?> parsed) {
//		val typeString = parsed.get("type") as String
//		val uuid = parsed.get("uuid") as String
//		var task = context.getService(uuid) as ITask
//		if (task == null) {
//			val type = Class.forName(typeString) as Class<? extends ITask>
//			val injector = context.getService(IInjector)
//			task = injector.deploy(type, uuid)
//		}
//		return task
//	}
	def protected void adaptLabel(ITask task, Map<?, ?> parsed) {
		val label = parsed.get("label") as String
		task.label = label
	}

	def protected void adaptExternalExceptions(ITask task, Map<?, ?> parsed) {
		val exceptions = parsed.get("exceptions") as List<Map<String, String>>
		exceptions?.forEach [
			val uuid = get("uuid")
			val label = get("label")
			val exception = new TaskException(label)
			task.addException(exception)
			exceptionsCache.put(uuid, exception)
		]
	}

	def protected void adaptExternalInputs(ITask task, Map<?, ?> parsed) {
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

	def protected void adaptExternalOutputs(ITask task, Map<?, ?> parsed) {
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