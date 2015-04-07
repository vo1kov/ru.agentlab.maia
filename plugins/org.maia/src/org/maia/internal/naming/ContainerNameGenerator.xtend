package org.maia.internal.naming

import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IContextFactory
import org.maia.naming.IContainerNameGenerator

class ContainerNameGenerator implements IContainerNameGenerator {

	@Inject
	IEclipseContext context

	override generate() {
		val containers = context.get(IContextFactory.KEY_CONTAINERS) as List<IEclipseContext>
		if (containers != null) {
			// TODO: make sure that name unique
			val count = containers.size + 1
			return "Container_" + count
		} else {
			return "Container_0"
		}
	}

}