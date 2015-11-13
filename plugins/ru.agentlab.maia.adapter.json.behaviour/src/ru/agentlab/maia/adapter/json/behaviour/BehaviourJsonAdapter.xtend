package ru.agentlab.maia.adapter.json.behaviour

import ru.agentlab.maia.adapter.json.JsonAdapter
import ru.agentlab.maia.behaviour.IBehaviour
import java.util.Map
import java.util.UUID

class BehaviourJsonAdapter extends JsonAdapter<IBehaviour> {
	
	new(Map<UUID, IBehaviour> registry) {
		super(registry)
	}
	
}