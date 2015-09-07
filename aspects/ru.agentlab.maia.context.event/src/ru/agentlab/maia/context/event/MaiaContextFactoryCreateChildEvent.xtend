package ru.agentlab.maia.context.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.memory.IMaiaContext

class MaiaContextFactoryCreateChildEvent implements IMaiaEvent {

	val protected static String KEY_PARENT_CONTEXT = "context.parent"

	val protected static String KEY_CONTEXT = "context"

	val public static String TOPIC = "ru/agentlab/maia/context/factory/CreateChild"

	@Accessors
	val data = new HashMap<String, Object>

	new(IMaiaContext parentContext, IMaiaContext context) {
		data.put(KEY_PARENT_CONTEXT, parentContext)
		data.put(KEY_CONTEXT, context)
	}

	override getTopic() {
		return TOPIC
	}

	def IMaiaContext getContext() {
		return data.get(KEY_CONTEXT) as IMaiaContext
	}

	def IMaiaContext getParentContext() {
		return data.get(KEY_PARENT_CONTEXT) as IMaiaContext
	}

}