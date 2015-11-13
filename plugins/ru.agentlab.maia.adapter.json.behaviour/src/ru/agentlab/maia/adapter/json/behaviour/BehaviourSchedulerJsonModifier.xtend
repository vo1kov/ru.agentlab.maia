package ru.agentlab.maia.adapter.json.behaviour

import java.util.List
import java.util.Map
import ru.agentlab.maia.behaviour.BehaviourScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

class BehaviourSchedulerJsonModifier extends BehaviourJsonModifier {

	val public static String KEY_SUBTASKS = "subtasks"

	val public static String KEY_DATAFLOW = "dataflow"

	override modify(IBehaviour task, Object... objects) {
		val parsed = objects.get(0) as Map<String, ?>
		if (task instanceof BehaviourScheduler) {
			super.modify(task, parsed)
			task.modifySubtasks(parsed)
			task.modifyDataflow(parsed)
		} else {
			throw new IllegalArgumentException
		}
	}

	def protected void modifySubtasks(IBehaviourScheduler scheduler, Map<String, ?> internal) {
		val subtasks = internal.get(KEY_SUBTASKS) as List<Map<String, ?>>
		subtasks?.forEach [
			val type = it.get(TASK_TYPE) as String
			val modifier = JsonTaskAdapter.getModifier(LANGUAGE, type)
			modifier.modify()
			JsonTaskAdapter.callModifier()
			val subtask = super.adapt(it)
			scheduler.addChild(subtask)
			val uuid = it.get("uuid") as String
			subtasksCache.put(uuid, subtask)
		]
	}

	def protected void modifyDataflow(IBehaviourScheduler scheduler, Map<String, ?> internal) {
		val links = internal.get(KEY_DATAFLOW) as List<List<String>>
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