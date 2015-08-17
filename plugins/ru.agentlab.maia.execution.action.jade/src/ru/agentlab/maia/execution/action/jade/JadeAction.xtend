package ru.agentlab.maia.execution.action.jade

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.IMaiaExecutorAction
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

class JadeAction implements IMaiaExecutorAction {

	@Accessors
	var IMaiaExecutorScheduler parentNode

	override run() {
	}

}