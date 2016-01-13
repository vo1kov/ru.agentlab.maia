package ru.agentlab.maia.adapter.json.behaviour.sequential

import com.google.gson.JsonArray
import com.google.gson.JsonObject
import com.google.gson.JsonPrimitive
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential

class SequentialBehaviourSerializer implements JsonSerializer<BehaviourSchedulerSequential> {
	
	override serialize(BehaviourSchedulerSequential src, Type typeOfSrc, JsonSerializationContext context) {
		return new JsonObject => [
			addProperty("uuid", src.uuid.toString)
			addProperty("type", src.class.name)
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