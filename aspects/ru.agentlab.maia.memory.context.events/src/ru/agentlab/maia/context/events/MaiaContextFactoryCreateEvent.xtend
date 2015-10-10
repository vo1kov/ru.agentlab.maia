package ru.agentlab.maia.context.events

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextFactoryCreateEvent implements IMaiaEvent {

	val protected static String KEY_CONTEXT = "context"

	val public static String TOPIC = "ru/agentlab/maia/context/factory/CreateContext"

	@Accessors
	val data = new HashMap<String, Object>

	new(IContext context) {
		data.put(KEY_CONTEXT, context)
	}

	override getTopic() {
		return TOPIC
	}

	def IContext getContext() {
		return data.get(KEY_CONTEXT) as IContext
	}

}