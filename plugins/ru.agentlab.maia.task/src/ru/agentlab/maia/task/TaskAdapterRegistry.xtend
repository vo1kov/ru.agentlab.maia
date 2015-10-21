package ru.agentlab.maia.task

import java.util.HashMap
import java.util.Map

class TaskAdapterRegistry implements ITaskAdapterRegistry {

	val Map<String, ITaskAdapter<?>> adapters = new HashMap

	override ITaskAdapter<?> getAdapter(String id) {
		return adapters.get(id)
	}

	override void putAdapter(String id, ITaskAdapter<?> adapter) {
		adapters.put(id, adapter)
	}
	
	override void removeAdapter(String id){
		adapters.remove(id)
	}

}