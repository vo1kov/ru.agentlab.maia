package ru.agentlab.maia.adapter.behaviour.json

import java.util.List
import java.util.Map
import ru.agentlab.maia.adapter.behaviour.json.internal.Activator
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.Scheduler
import ru.agentlab.maia.behaviour.IBehaviourScheduler

class BehaviourSchedulerJsonModifier extends BehaviourJsonModifier {

	val public static String KEY_SUBTASKS = "subtasks"

	val public static String KEY_DATAFLOW = "dataflow"

	override modify(IBehaviour task, Object... objects) {
		val parsed = objects.get(0) as Map<String, ?>
		if (task instanceof Scheduler) {
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
			val json = it.toString
			val language = BehaviourJsonAdapter.LANGUAGE
			val adapter = Activator.getAdapter(language)
			if (adapter != null) {
				val child = adapter.adapt(json)
				scheduler.addChild(child)
				val uuid = it.get("uuid") as String
				subtasksCache.put(uuid, child)
			} else {
				throw new RuntimeException('''Adapter for [«language»] is not registered''')
			}
		]
	}

	def protected void modifyDataflow(IBehaviourScheduler scheduler, Map<String, ?> internal) {
		val links = internal.get(KEY_DATAFLOW) as List<List<String>>
		links?.forEach [ link |
			for (uuid : link) {
				if (!parametersCache.containsKey(uuid)) {
					throw new IllegalStateException('''Loaded task have no any parameter with UUID: [«uuid»]''')
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