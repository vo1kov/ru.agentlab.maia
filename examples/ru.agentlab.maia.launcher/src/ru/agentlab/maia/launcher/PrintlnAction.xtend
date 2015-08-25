package ru.agentlab.maia.launcher

import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.annotation.Action

class PrintlnAction {

	@Inject
	IMaiaContext context

	@Action
	def void execute() {
		println(Thread.currentThread.name + " " + context)
	}
}