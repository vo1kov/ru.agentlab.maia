package ru.agentlab.maia.container.events

import java.lang.annotation.Annotation
import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent

class MaiaContextInjectorInvokeEvent implements IMaiaEvent {

	val protected static String KEY_OBJECT = "object"

	val protected static String KEY_ANNOTATION = "annotation"

	val public static String TOPIC = "ru/agentlab/maia/context/injector/Invoke"

	@Accessors
	val data = new HashMap<String, Object>

	new(Object object, Class<? extends Annotation> ann) {
		data.put(KEY_OBJECT, object)
		data.put(KEY_ANNOTATION, ann)
	}

	override getTopic() {
		return TOPIC
	}

	def Object getObject() {
		return data.get(KEY_OBJECT)
	}

	def Class<? extends Annotation> getAnnotation() {
		return data.get(KEY_ANNOTATION) as Class<? extends Annotation>
	}

}