package ru.agentlab.maia.adapter.behaviour.json

import com.google.gson.JsonSerializer
import ru.agentlab.maia.behaviour.Behaviour
import java.lang.reflect.Type
import com.google.gson.JsonSerializationContext

class SeqSeria implements JsonSerializer<Behaviour>{
	
	override serialize(Behaviour src, Type typeOfSrc, JsonSerializationContext context) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}