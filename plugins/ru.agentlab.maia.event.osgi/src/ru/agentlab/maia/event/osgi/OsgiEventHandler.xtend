package ru.agentlab.maia.event.osgi

import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.service.event.Event
import org.osgi.service.event.EventHandler
import ru.agentlab.maia.event.IMaiaEventHandler

@Accessors
class OsgiEventHandler implements EventHandler {

	IMaiaEventHandler handler

	new(IMaiaEventHandler handler) {
		this.handler = handler
	}

	override handleEvent(Event event) {
		if (event instanceof OsgiEvent) {
			handler.handle(event.event)
		} else {
			throw new IllegalStateException
		}
	}

}