package ru.agentlab.maia.adapter.json

import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonPrimitive

class ClassSerialzer implements JsonSerializer<Class<?>> {

	override serialize(Class<?> src, Type typeOfSrc, JsonSerializationContext context) {
		return new JsonPrimitive(src.name)
	}

}