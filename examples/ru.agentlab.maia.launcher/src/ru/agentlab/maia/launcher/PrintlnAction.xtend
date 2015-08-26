package ru.agentlab.maia.launcher

import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Optional

class PrintlnAction {

	@Inject
	IMaiaContext context

	@Optional @Input
	String input

	@Action
	def void execute() {
		println(Thread.currentThread.name + " " + context + "	" + input)
	}
}