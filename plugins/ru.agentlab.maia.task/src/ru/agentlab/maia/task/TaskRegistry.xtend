package ru.agentlab.maia.task

import java.util.Map
import java.util.TreeMap

class TaskRegistry implements ITaskRegistry {

	val Map<String, ITask> tasks = new TreeMap

	override void put(String uuid, ITask task) {
		tasks.put(uuid, task)
	}

	override ITask get(String uuid) {
		return tasks.get(uuid)
	}
	
	override ITask remove(String uuid){
		return tasks.remove(uuid)
	}

}