package ru.agentlab.maia.internal.naming

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.naming.IContainerNameGenerator

class ContainerNameGenerator implements IContainerNameGenerator {

	override generate(IEclipseContext context) {
		val platform = context.get("ru.agentlab.maia.platform") as IEclipseContext
		if (platform != null) {
			// TODO: make sure that name unique
			val containers = platform.get("ru.agentlab.maia.platform.containers") as List<IEclipseContext>
			val count = containers.size + 1
			return "Container" + count
		} else {
			return "Container"
		}
	}

}