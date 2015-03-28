package ru.agentlab.maia.internal.naming

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.naming.IAgentNameGenerator

class AgentNameGenerator implements IAgentNameGenerator {

	override generate(IEclipseContext context) {
		val platform = context.get("ru.agentlab.maia.container") as IEclipseContext
		if (platform != null) {
			// TODO: make sure that name unique
			val containers = platform.get("ru.agentlab.maia.container.agents") as List<IEclipseContext>
			val count = containers.size + 1
			return "Agent" + count
		} else {
			return "Agent"
		}
	}

}