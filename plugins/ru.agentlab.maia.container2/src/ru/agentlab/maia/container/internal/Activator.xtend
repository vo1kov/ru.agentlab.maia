package ru.agentlab.maia.container.internal

import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile => [
			put(IContainerFactory, ContainerFactory)
		]
	}

}
