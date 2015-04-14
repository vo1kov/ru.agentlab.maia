package ru.agentlab.maia.event.osgi

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.service.event.Event
import ru.agentlab.maia.event.IMaiaEvent

@Accessors
class OsgiEvent implements IMaiaEvent {

	Event osgiEvent

	new(Event osgiEvent) {
		this.osgiEvent = osgiEvent
	}

	override getTopic() {
		return osgiEvent.topic
	}

	override getData() {
		val result = new HashMap<String, Object>
		osgiEvent.propertyNames.forEach [
			result.put(it, osgiEvent.getProperty(it))
		]
		return result
	}

}