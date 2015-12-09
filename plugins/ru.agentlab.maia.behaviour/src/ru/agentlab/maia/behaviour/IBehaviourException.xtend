package ru.agentlab.maia.behaviour

interface IBehaviourException extends IExecutionStep {
	
	def String getName()

	def void setName(String newName)
	
//	def IBehaviourException getCause()

}