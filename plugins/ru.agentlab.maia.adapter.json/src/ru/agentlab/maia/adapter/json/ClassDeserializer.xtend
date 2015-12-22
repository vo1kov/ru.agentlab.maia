package ru.agentlab.maia.adapter.json

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonParseException
import java.lang.reflect.Type

class ClassDeserializer implements JsonDeserializer<Class<?>> {

	override deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
		val name = json.asString
		return Class.forName(name)
	}

}