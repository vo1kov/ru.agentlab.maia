package ru.agentlab.maia.context.events

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextInjectorInjectEvent implements IMaiaEvent {

	val protected static String KEY_OBJECT = "object"

	val public static String TOPIC = "ru/agentlab/maia/context/injector/Inject"

	@Accessors
	val data = new HashMap<String, Object>

	new(Object object) {
		data.put(KEY_OBJECT, object)
	}

	override getTopic() {
		return TOPIC
	}

	def Object getObject() {
		return data.get(KEY_OBJECT)
	}

}