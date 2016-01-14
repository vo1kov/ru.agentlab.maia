package ru.agentlab.maia.adapter.behaviour.json

import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import ru.agentlab.maia.behaviour.Behaviour

class SeqSeria implements JsonSerializer<Behaviour>{
	
	override serialize(Behaviour src, Type typeOfSrc, JsonSerializationContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}