package ru.agentlab.maia.context.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextChangeObjectEvent implements IMaiaEvent {

	val protected static String KEY_FROM_OBJECT = "from.object"

	val protected static String KEY_TO_OBJECT = "to.object"

	val public static String TOPIC = "ru/agentlab/maia/context/ChangeObject"

	@Accessors
	val data = new HashMap<String, Object>

	new(Object fromObject, Object toObject) {
		data.put(KEY_FROM_OBJECT, fromObject)
		data.put(KEY_TO_OBJECT, toObject)
	}

	override getTopic() {
		return TOPIC
	}

	def Object getFromObject() {
		return data.get(KEY_FROM_OBJECT)
	}

	def Object getToObject() {
		return data.get(KEY_TO_OBJECT)
	}

}