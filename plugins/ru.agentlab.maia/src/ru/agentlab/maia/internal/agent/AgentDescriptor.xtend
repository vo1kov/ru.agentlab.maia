package ru.agentlab.maia.internal.agent

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.container.IContainerId

class AgentDescriptor {

	public static final boolean NATIVE_AGENT = false
	public static final boolean FOREIGN_AGENT = true

	@Accessors
	private AmsAgentDescription description
	
	@Accessors
	private boolean foreign
	
	@Accessors
	private IContainerId containerID
	
//	@Accessors
//	private JADEPrincipal principal
//	
//	@Accessors
//	private Credentials amsDelegation

}