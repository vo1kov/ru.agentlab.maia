package ru.agentlab.maia.event.osgi

import org.eclipse.xtend.lib.annotations.Accessors
import org.osgi.service.event.Event
import ru.agentlab.maia.event.IMaiaEvent

@Accessors
class OsgiEvent extends Event {

	IMaiaEvent event

	new(IMaiaEvent event) {
		super(event.topic, event.data)
		this.event = event
	}

}