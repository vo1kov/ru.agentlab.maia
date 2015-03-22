package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.platform.IPlatform

@Accessors
class Container implements IContainer {

	var IPlatform platform

	var IContainerId containerId

	val List<IAgent> agents = new ArrayList<IAgent>

}