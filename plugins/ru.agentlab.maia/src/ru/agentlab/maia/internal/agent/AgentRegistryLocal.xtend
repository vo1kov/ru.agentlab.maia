package ru.agentlab.maia.internal.agent

import java.util.concurrent.ConcurrentHashMap
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.agent.IAgentId

class AgentRegistryLocal {

	var agents = new ConcurrentHashMap<IAgentId, IEclipseContext>

	def void put(IAgentId aid, IEclipseContext a) {
		agents.put(aid, a)
	}

	def IEclipseContext get(IAgentId aid) {
		agents.get(aid)
	}

	def void remove(IAgentId key) {
		agents.remove(key)
	}

	def IAgentId[] keys() {
		agents.keySet
	}

	def IEclipseContext[] values() {
		agents.values
	}

	def boolean contains(IAgentId key) {
		agents.containsKey(key)
	}

}
