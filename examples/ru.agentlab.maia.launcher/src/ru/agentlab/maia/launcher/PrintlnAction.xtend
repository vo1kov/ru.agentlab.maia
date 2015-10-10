package ru.agentlab.maia.launcher

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Optional
import ru.agentlab.maia.context.IContext

class PrintlnAction {

	@Inject
	IContext context

	@Optional @Input
	String input

	@Action
	def void execute() {
		println(Thread.currentThread.name + " " + context + "	" + input)
	}
}