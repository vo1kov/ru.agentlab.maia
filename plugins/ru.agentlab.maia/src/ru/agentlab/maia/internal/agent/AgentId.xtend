package ru.agentlab.maia.internal.agent

import java.util.ArrayList
import java.util.List
import java.util.Properties
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId

class AgentId implements IAgentId {
	
	@Accessors
	private String platformID
	
	@Accessors
	private String name
	
	@Accessors
	private List<String> addresses = new ArrayList<String>
	
	@Accessors
	private List<IAgentId> resolvers = new ArrayList<IAgentId>
	
	@Accessors
	private Properties userDefSlots = new Properties
	
}