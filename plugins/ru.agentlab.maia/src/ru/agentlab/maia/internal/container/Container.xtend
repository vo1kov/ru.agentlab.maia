package ru.agentlab.maia.internal.container

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.platform.IPlatform

@Accessors
class Container implements IContainer {

	@Inject
	IEclipseContext context

	@Inject
	var IContainerId id

	@Inject
	var IPlatform root

	val List<IAgent> childs = new ArrayList<IAgent>

}