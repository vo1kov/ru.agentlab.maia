package ru.agentlab.maia.lifecycle.fipa.internal

import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.lifecycle.fipa.FipaLifecycleServiceFactory
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile => [
			put(ILifecycleServiceFactory, FipaLifecycleServiceFactory)
		]
	}

}
