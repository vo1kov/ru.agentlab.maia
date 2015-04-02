package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.behaviour.sheme.BehaviourScheme
import ru.agentlab.maia.behaviour.sheme.BehaviourSchemeOneShot
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMappingFactory
import ru.agentlab.maia.launcher.task.ContextDumpTask

class BehaviourExample {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample)

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourTaskMappingFactory behaviourTaskMappingFactory

	@Inject
	BehaviourSchemeOneShot oneShotScheme
	
	@PostConstruct
	def void init() {
		LOGGER.info("Modify action scheme...")
		context.modify(BehaviourScheme, oneShotScheme)
		LOGGER.info("Modify scheme mapping...")
		val mapping = behaviourTaskMappingFactory.create => [
			val task = ContextInjectionFactory.make(ContextDumpTask, context)
			put(BehaviourSchemeOneShot.STATE_MAIN, task)
		]
		context.modify(IBehaviourTaskMapping, mapping)
	}

}