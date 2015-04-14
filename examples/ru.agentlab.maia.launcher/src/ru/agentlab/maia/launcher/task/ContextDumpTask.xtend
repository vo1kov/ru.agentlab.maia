package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.maia.task.Action
import org.slf4j.LoggerFactory

class ContextDumpTask {

	val static LOGGER = LoggerFactory.getLogger(ContextDumpTask)

	@Inject
	IEclipseContext context

	@Action
	def void action() {
		var cc = context
		while (cc != null) {
			val c = cc
			println("Context [" + c + "] consist of:")
			(c as EclipseContext).localData.keySet.sortWith [ a, b |
				a.compareTo(b)
			].forEach [ p1 |
				println("	[" + p1 + "] -> [" + (c as EclipseContext).localData.get(p1) + "]")
			]
			cc = c.parent
		}
	}

}