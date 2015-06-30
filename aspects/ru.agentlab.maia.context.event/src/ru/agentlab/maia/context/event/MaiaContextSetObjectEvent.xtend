package ru.agentlab.maia.context.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextSetObjectEvent implements IMaiaEvent {

	val protected static String KEY_CONTEXT = "context"

	val protected static String KEY_OBJECT = "object"

	val public static String TOPIC = "ru/agentlab/maia/context/SetObject"

	@Accessors
	val data = new HashMap<String, Object>

	new(IMaiaContext context, Object object) {
		data.put(KEY_CONTEXT, context)
		data.put(KEY_OBJECT, object)
	}

	override getTopic() {
		return TOPIC
	}

	def IMaiaContext getContext() {
		return data.get(KEY_CONTEXT) as IMaiaContext
	}

	def Object getObject() {
		return data.get(KEY_OBJECT)
	}

}