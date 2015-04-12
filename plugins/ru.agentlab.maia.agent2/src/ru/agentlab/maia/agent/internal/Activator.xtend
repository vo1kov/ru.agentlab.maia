package ru.agentlab.maia.agent.internal

import ru.agentlab.maia.MaiaProfileActivator
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.profile.MaiaProfile

class Activator extends MaiaProfileActivator {

	override getProfile() {
		new MaiaProfile => [
			put(IAgentFactory, AgentFactory)
		]
	}

}
