package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.behaviour.IBehaviourId
import ru.agentlab.maia.container.IContainerId

@Accessors
class AgentId implements IAgentId {

	var IContainerId containerId

	val List<IBehaviourId> behaviourIds = new ArrayList<IBehaviourId>

	var String name

	val List<String> addresses = new ArrayList<String>

	val List<IAgentId> resolvers = new ArrayList<IAgentId>

	override toString() {
		name
	}

	override equals(Object obj) {
		if (obj instanceof AgentId) {
			return name == obj.name
		} else {
			return false
		}
	}

}