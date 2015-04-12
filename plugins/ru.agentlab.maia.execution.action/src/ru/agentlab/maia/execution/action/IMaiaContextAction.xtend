package ru.agentlab.maia.execution.action

interface IMaiaContextAction {
	
	val static String KEY_TASK = "task"
	
	val static String KEY_RESULT = "result"
	
	def void beforeAction()
	
	def Object action()
	
	def void afterAction()
	
}