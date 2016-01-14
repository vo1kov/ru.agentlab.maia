package ru.agentlab.maia.adapter.behaviour.json

import com.google.gson.JsonObject
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import ru.agentlab.maia.IBehaviour

class BehaviourSerializer implements JsonSerializer<IBehaviour> {

	override serialize(IBehaviour src, Type typeOfSrc, JsonSerializationContext context) {
		return new JsonObject => [
			addProperty("uuid", src.uuid.toString)
			add("inputs", context.serialize(src.inputs))
			add("outputs", context.serialize(src.outputs))
			add("exceptions", context.serialize(src.exceptions))
		]
	}

}