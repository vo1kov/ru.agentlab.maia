package ru.agentlab.maia.context.events

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextSetObjectEvent implements IMaiaEvent {

	val protected static String KEY_CONTEXT = "context"

	val protected static String KEY_OBJECT = "object"

	val public static String TOPIC = "ru/agentlab/maia/context/SetObject"

	@Accessors
	val data = new HashMap<String, Object>

	new(IContext context, Object object) {
		data.put(KEY_CONTEXT, context)
		data.put(KEY_OBJECT, object)
	}

	override getTopic() {
		return TOPIC
	}

	def IContext getContext() {
		return data.get(KEY_CONTEXT) as IContext
	}

	def Object getObject() {
		return data.get(KEY_OBJECT)
	}

}