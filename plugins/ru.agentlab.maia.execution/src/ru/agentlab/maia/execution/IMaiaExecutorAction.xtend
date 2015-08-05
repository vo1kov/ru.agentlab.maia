package ru.agentlab.maia.execution

interface IMaiaExecutorAction extends IMaiaExecutorNode {

	val static String KEY_TASK = "ru.agentlab.maia.execution.action|task"

	val static String KEY_RESULT = "ru.agentlab.maia.execution.action|result"

	def void beforeRun()

	def Object run()

	def void afterRun()

}