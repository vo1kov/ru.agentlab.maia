package ru.agentlab.maia.task.adapter.json

import java.util.List
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.ITaskScheduler

class JsonTaskSchedulerAdapter extends JsonTaskAdapter {

	@Inject
	new(ITaskRegistry registry) {
		super(registry)
	}

	override adapt(Map<?, ?> parsed) {
		val task = super.adapt(parsed)
		if (task instanceof ITaskScheduler) {
			val internal = parsed.get("internal") as Map<?, ?>
			task.internalAdaptSubtasks(internal)
			task.internalAdaptDataflow(internal)
			return task
		} else {
			throw new IllegalArgumentException
		}
	}

	def protected void internalAdaptSubtasks(ITaskScheduler scheduler, Map<?, ?> internal) {
		val subtasks = internal.get("subtasks") as List<Map<?, ?>>
		subtasks?.forEach [
			val subtask = super.adapt(it)
			scheduler.addSubtask(subtask)
			val uuid = it.get("uuid") as String
			subtasksCache.put(uuid, subtask)
		]
	}

	def protected void internalAdaptDataflow(ITaskScheduler scheduler, Map<?, ?> internal) {
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