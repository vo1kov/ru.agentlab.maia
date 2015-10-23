package ru.agentlab.maia.task.adapter.json

import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.context.IInjector

class JsonTaskSchedulerAdapter extends JsonTaskAdapter {

	new(IInjector injector) {
		super(injector)
	}
	
	override adapt(String json) {
		val task = super.adapt(json)
		if (task instanceof ITaskScheduler) {
			return task => [
				extractSubtasks(parsed)
				extractDataflow(parsed)
			]
		} else {
			throw new IllegalArgumentException
		}
	}

	def protected void extractSubtasks(ITaskScheduler scheduler, Map<?, ?> parsed) {
		val subtasks = parsed.get("subtasks") as List<Map<?, ?>>
		subtasks?.forEach [
			val subtask = super.adapt(it)
			scheduler.addSubtask(subtask)
			subtasksCache.put(subtask.uuid, subtask)
		]
	}

	def protected void extractDataflow(ITaskScheduler scheduler, Map<?, ?> parsed) {
		val links = parsed.get("dataflow") as List<List<String>>
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