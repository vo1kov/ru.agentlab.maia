package ru.agentlab.maia.execution.tree

interface IExecutionAction extends IExecutionNode {
	
	val static String KEY_TASK = "ru.agentlab.maia.execution.action|task"

	val static String KEY_RESULT = "ru.agentlab.maia.execution.action|result"
	
	def Class<?> getActionClass()
	
}