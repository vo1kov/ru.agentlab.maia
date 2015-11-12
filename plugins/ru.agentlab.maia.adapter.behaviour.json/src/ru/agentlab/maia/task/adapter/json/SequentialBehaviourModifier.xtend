package ru.agentlab.maia.behaviour.sequential

import java.util.List
import java.util.Map
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler
import ru.agentlab.maia.behaviour.BehaviourOrdered
import ru.agentlab.maia.behaviour.BehaviourSchedulerModifier

class SequentialBehaviourModifier extends BehaviourSchedulerModifier {

	override modify(IBehaviour task, Map<String, ?> parsed) {
		if (task instanceof BehaviourOrdered) {
			super.modify(task, parsed)
			task.modifySubtasks(parsed)
			task.modifyDataflow(parsed)
		} else {
			throw new IllegalArgumentException
		}
	}

	def protected void modifySubtasks(IBehaviourScheduler scheduler, Map<String, ?> internal) {
		val subtasks = internal.get(TaskSchedulerModifier.TASK_SCHEDULER_SUBTASKS) as List<Map<String, ?>>
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
		val links = internal.get(TaskSchedulerModifier.TASK_SCHEDULER_DATAFLOW) as List<List<String>>
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