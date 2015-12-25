package ru.agentlab.maia.adapter.behaviour.json

import com.google.gson.JsonArray
import com.google.gson.JsonObject
import com.google.gson.JsonPrimitive
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import ru.agentlab.maia.behaviour.IBehaviourScheduler

class BehaviourSchedulerSerializer implements JsonSerializer<IBehaviourScheduler> {

	override serialize(IBehaviourScheduler src, Type typeOfSrc, JsonSerializationContext context) {
		return new JsonObject => [
			addProperty("uuid", src.uuid.toString)
			add("inputs", context.serialize(src.inputs))
			add("outputs", context.serialize(src.outputs))
			add("exceptions", context.serialize(src.exceptions))
			val childsArray = new JsonArray
			src.childs.forEach [
				childsArray.add(new JsonPrimitive(it.uuid.toString))
			]
			add("childs", childsArray)
		]
	}

}