package ru.agentlab.maia.task.adapter.json

import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskSchedulerOrdered

class JsonTaskSchedulerOrderedModifier extends JsonTaskModifier {

	override modify(ITask task, Map<String, ?> parsed) {
		if (task instanceof TaskSchedulerOrdered) {
			super.modify(task, parsed)
			task.modifySubtasks(parsed)
			task.modifyDataflow(parsed)
		} else {
			throw new IllegalArgumentException
		}
	}

	def protected void modifySubtasks(ITaskScheduler scheduler, Map<String, ?> internal) {
		val subtasks = internal.get(JsonConstants.TASK_SUBTASKS) as List<Map<String, ?>>
		subtasks?.forEach [
			val type = it.get(JsonConstants.TASK_TYPE) as String
			val modifier = JsonTaskAdapter.getModifier(JsonConstants.LANGUAGE, type)
			modifier.modify()
			JsonTaskAdapter.callModifier()
			val subtask = super.adapt(it)
			scheduler.addSubtask(subtask)
			val uuid = it.get("uuid") as String
			subtasksCache.put(uuid, subtask)
		]
	}

	def protected void modifyDataflow(ITaskScheduler scheduler, Map<String, ?> internal) {
		val links = internal.get(JsonConstants.TASK_DATAFLOW) as List<List<String>>
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