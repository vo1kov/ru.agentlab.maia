package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.platform.IPlatformId

@Accessors
class ContainerId implements IContainerId {

	var String name

	var String address

	IPlatformId platformId

	val List<IAgentId> agentIds = new ArrayList<IAgentId>

}