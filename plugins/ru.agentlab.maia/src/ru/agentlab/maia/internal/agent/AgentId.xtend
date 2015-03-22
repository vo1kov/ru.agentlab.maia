package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import java.util.Properties
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId

class AgentId implements IAgentId {
	
	@Accessors
	var String platformID
	
	@Accessors
	var String name
	
	@Accessors
	var List<String> addresses = new ArrayList<String>
	
	@Accessors
	var List<IAgentId> resolvers = new ArrayList<IAgentId>
	
	@Accessors
	var Properties userDefSlots = new Properties
	
}