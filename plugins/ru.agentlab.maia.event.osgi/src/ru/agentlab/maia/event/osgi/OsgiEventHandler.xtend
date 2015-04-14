package ru.agentlab.maia.event.osgi

import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.service.event.EventHandler
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.event.IMaiaEventHandler

@Accessors
class OsgiEventHandler implements IMaiaEventHandler {

	EventHandler handler

	new(EventHandler handler) {
		this.handler = handler
	}

	override handle(IMaiaEvent event) {
		if (event instanceof OsgiEvent) {
			val osgiEvent = event.getOsgiEvent
			handler.handleEvent(osgiEvent)
		} else {
			throw new IllegalStateException("Non OSGI event is not supported with installed Broker")
		}
	}

}