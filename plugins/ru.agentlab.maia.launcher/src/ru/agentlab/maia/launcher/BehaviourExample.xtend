package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.behaviour.IActionMapping
import ru.agentlab.maia.internal.behaviour.ActionMapping
import ru.agentlab.maia.internal.behaviour.ActionSchemeOneShot
import ru.agentlab.maia.launcher.task.ContextDumpTask

class BehaviourExample {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample)

	@Inject
	IEclipseContext context

	@PostConstruct
	def void init() {
//		LOGGER.info("Modify action scheme...")
//		context.modify(IActionScheme, new ActionSchemeOneShot)
		LOGGER.info("Modify scheme mapping...")
		val mapping = new ActionMapping => [
			val task = ContextInjectionFactory.make(ContextDumpTask, context)
			map.put(ActionSchemeOneShot.STATE_MAIN, task)
		]
		context.modify(IActionMapping, mapping)
	}

}