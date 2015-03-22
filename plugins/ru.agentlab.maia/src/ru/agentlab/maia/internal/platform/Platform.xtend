package ru.agentlab.maia.internal.platform

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.container.IContainer
import ru.agentlab.maia.platform.IPlatform
import ru.agentlab.maia.platform.IPlatformId

@Accessors
class Platform implements IPlatform {

	@Inject
	IEclipseContext context

	var IPlatformId platformId

	val List<IContainer> containers = new ArrayList<IContainer>
}