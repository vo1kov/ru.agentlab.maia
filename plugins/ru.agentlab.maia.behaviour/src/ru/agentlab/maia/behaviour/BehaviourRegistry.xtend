package ru.agentlab.maia.behaviour

import java.util.Map
import java.util.TreeMap
import java.util.UUID

class BehaviourRegistry implements IBehaviourRegistry {

	val Map<UUID, IBehaviour> behaviours = new TreeMap

	override IBehaviour put(UUID uuid, IBehaviour task) {
		behaviours.put(uuid, task)
	}

	override IBehaviour get(UUID uuid) {
		return behaviours.get(uuid)
	}

	override IBehaviour remove(UUID uuid) {
		return behaviours.remove(uuid)
	}

	override getMap() {
		return behaviours
	}

}