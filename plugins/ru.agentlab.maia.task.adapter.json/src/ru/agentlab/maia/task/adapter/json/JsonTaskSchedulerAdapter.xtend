package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.adapter.ITaskAdapterElement

class JsonTaskSchedulerAdapter implements ITaskAdapterElement<String> {

	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	override adapt(ITask task, String json) {
		if (task instanceof ITaskScheduler) {
			val internal = JsonPath.using(conf).parse(json).read("$.internal") as Map<?, ?>
			task.adapt(internal)
		} else {
			throw new IllegalArgumentException
		}
	}

	def ITaskScheduler adapt(ITaskScheduler task, Map<?, ?> internal) {
		task.extractSubtasks(internal)
		task.extractDataflow(internal)
		return task
	}

	def protected void extractSubtasks(ITaskScheduler scheduler, Map<?, ?> internal) {
		val subtasks = internal.get("subtasks") as List<Map<?, ?>>
		subtasks?.forEach [
			val subtask = super.adapt(it)
			scheduler.addSubtask(subtask)
			val uuid = it.get("uuid") as String
			subtasksCache.put(uuid, subtask)
		]
	}

	def protected void extractDataflow(ITaskScheduler scheduler, Map<?, ?> internal) {
		val links = internal.get("dataflow") as List<List<String>>
		links?.forEach [ link |
			for (uuid : link) {
				if (!parametersCache.containsKey(uuid)) {
					throw new IllegalStateException("Loaded task have no any parameter with UUID: " + uuid)
				}
//				val parameter = parametersCache.get(uuid)
//				parameter.link()
			}

//			val subtask = super.adapt(it)
//			scheduler.addSubtask(subtask)
//			subtasksCache.put(subtask.uuid, subtask)
		]
	}

} 