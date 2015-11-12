package ru.agentlab.maia.behaviour

import java.util.Map
import java.util.TreeMap

class BehaviourRegistry implements IBehaviourRegistry {

	val Map<String, IBehaviour> tasks = new TreeMap

	override void put(String uuid, IBehaviour task) {
		tasks.put(uuid, task)
	}

	override IBehaviour get(String uuid) {
		return tasks.get(uuid)
	}
	
	override IBehaviour remove(String uuid){
		return tasks.remove(uuid)
	}

}