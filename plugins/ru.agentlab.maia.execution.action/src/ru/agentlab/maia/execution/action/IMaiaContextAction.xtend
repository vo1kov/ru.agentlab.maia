package ru.agentlab.maia.execution.action

import ru.agentlab.maia.execution.node.IMaiaExecutorNode

interface IMaiaContextAction extends IMaiaExecutorNode {

	val static String KEY_TASK = "task"

	val static String KEY_RESULT = "result"

	def void beforeRun()

	def Object run()

	def void afterRun()

}