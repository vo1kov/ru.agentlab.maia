package ru.agentlab.maia.execution.action.jade

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.IMaiaExecutorAction
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

class JadeContextAction implements IMaiaExecutorAction {

	@Accessors
	var IMaiaExecutorScheduler parentNode

//	@Inject
//	IMaiaContext context
//
//	@Inject
//	IMaiaContextInjector injector
	override beforeRun() {
	}

	override run() {
	}

	override afterRun() {
	}

}