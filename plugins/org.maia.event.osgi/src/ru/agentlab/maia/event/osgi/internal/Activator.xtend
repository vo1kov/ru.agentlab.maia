package ru.agentlab.maia.event.osgi.internal

import org.osgi.service.event.EventAdmin
import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile => []
	}

	def static EventAdmin getEventAdmin() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
