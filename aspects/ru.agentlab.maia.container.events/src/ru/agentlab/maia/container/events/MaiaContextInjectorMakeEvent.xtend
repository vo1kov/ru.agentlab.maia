package ru.agentlab.maia.container.events

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextInjectorMakeEvent implements IMaiaEvent {

	val protected static String KEY_CLASS = "class"
	
	val protected static String KEY_OBJECT = "object"

	val public static String TOPIC = "ru/agentlab/maia/context/injector/Make"

	@Accessors
	val data = new HashMap<String, Object>

	new(Class<?> clazz, Object object) {
		data.put(KEY_CLASS, clazz)
		data.put(KEY_OBJECT, object)
	}

	override getTopic() {
		return TOPIC
	}

	def Object getObject() {
		return data.get(KEY_OBJECT)
	}
	
	def Object getObjectClass() {
		return data.get(KEY_CLASS)
	}

}