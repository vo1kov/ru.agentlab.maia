package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action

class ContextDumpTask {

	val static LOGGER = LoggerFactory.getLogger(ContextDumpTask)

	@Inject
	IEclipseContext context

	@Action
	def void action() {
		var c = context
		while (c != null) {
			LOGGER.info("Context [{}] consist of:", c)
			(c as EclipseContext).localData.forEach [ p1, p2 |
				if (p1 != "org.eclipse.e4.core.internal.contexts.ContextObjectSupplier" && p1 != "debugString") {
					LOGGER.info("	[{}] -> [{}]", p1, p2)
				}
			]
			c = c.parent
		}
	}

}