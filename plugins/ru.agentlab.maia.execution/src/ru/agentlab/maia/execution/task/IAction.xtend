package ru.agentlab.maia.execution.task

interface IAction extends INode {
	
	def Class<?> getActionClass()
	
}