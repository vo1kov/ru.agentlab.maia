package ru.agentlab.maia.context.events

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextFactoryCreateChildEvent implements IMaiaEvent {

	val protected static String KEY_PARENT_CONTEXT = "context.parent"

	val protected static String KEY_CONTEXT = "context"

	val public static String TOPIC = "ru/agentlab/maia/context/factory/CreateChild"

	@Accessors
	val data = new HashMap<String, Object>

	new(IContext parentContext, IContext context) {
		data.put(KEY_PARENT_CONTEXT, parentContext)
		data.put(KEY_CONTEXT, context)
	}

	override getTopic() {
		return TOPIC
	}

	def IContext getContext() {
		return data.get(KEY_CONTEXT) as IContext
	}

	def IContext getParentContext() {
		return data.get(KEY_PARENT_CONTEXT) as IContext
	}

}