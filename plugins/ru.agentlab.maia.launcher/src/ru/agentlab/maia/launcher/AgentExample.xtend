package ru.agentlab.maia.launcher

import javax.inject.Inject
import ru.agentlab.maia.IAgent
import ru.agentlab.maia.annotation.Setup

class AgentExample {

	@Inject
	IAgent agent

	@Setup
	def void setup() {
		System.out.println("SETUP of: " + agent + " agent")
	}

}