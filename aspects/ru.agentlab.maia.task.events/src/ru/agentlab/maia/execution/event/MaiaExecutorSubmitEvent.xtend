package ru.agentlab.maia.execution.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.memory.IMaiaContext

class MaiaExecutorSubmitEvent implements IMaiaEvent {

	val protected static String KEY_CONTEXT = "context"

	val public static String TOPIC = "ru/agentlab/maia/execution/Submit"

	@Accessors
	val data = new HashMap<String, Object>

	new(IMaiaContext context) {
		data.put(KEY_CONTEXT, context)
	}

	override getTopic() {
		return TOPIC
	}

	def Object getContext() {
		return data.get(KEY_CONTEXT)
	}

}