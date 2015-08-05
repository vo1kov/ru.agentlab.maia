package ru.agentlab.maia.execution.action.annotated

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.execution.IMaiaExecutorAction
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

class AnnotatedContextAction implements IMaiaExecutorAction {

//	val static LOGGER = LoggerFactory.getLogger(AnnotatedContextAction)
	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	@Accessors
	var IMaiaExecutorScheduler parentNode

	@PostConstruct
	def void init() {
		parentNode = context.parent.get(IMaiaExecutorScheduler)
		if (parentNode != null) {
//			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentNode)
			parentNode.add(this)
		}
	}

	override beforeRun() {
	}

	override run() {
		val task = context.get(KEY_TASK)
		if (task != null) {
			return injector.invoke(task, Action, context)
		}
	}

	override afterRun() {
		parentNode.remove(this)
	}

}